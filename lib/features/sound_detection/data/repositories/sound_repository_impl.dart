// infrastructure/repositories/sound_recognition_repository_impl.dart
import 'dart:async';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:untitled3/features/sound_detection/data/data_sources/sound_local_datasource.dart';
import 'package:untitled3/features/sound_detection/domain/repositories/sound_repository.dart';

import '../../domain/entities/classification_result.dart';
import '../models/sound_classifier_model.dart';

class SoundRepositoryImpl implements SoundRepository {
  final SoundClassifier soundClassifier;
  final SoundLocalDataSource localDataSource;

  final AudioRecorder _audioRecorder = AudioRecorder(); // Handles microphone recording
  StreamController<List<ClassificationResult>>? _classificationController; // Stream to output results
  bool _isRecording = false; // Internal state flag
  List<int> _audioBuffer = []; // Buffer to accumulate audio bytes until a chunk is ready

  // Constructor takes the dependencies required for this implementation
  SoundRepositoryImpl(this.localDataSource,  this.soundClassifier);

  @override
  Stream<List<ClassificationResult>> detectSoundEvents(){

    if(_classificationController != null) return _classificationController!.stream;

    _classificationController = StreamController.broadcast();
    startClassification();
    return _classificationController!.stream;

    // if (_isRecording) {
    //   // Already recording, return the existing stream
    //   // Or you could throw an error depending on desired behavior
    //   print("2");
    //   print("Classification already started.");
    //   yield* _classificationController!.stream;
    //   return;
    // }
    //
    // // 1. Request Permission using the injected service
    // print("3");
    // final hasPermission = await requestMicrophonePermission();
    // print("4");
    // if (!hasPermission) {
    //   print("Microphone permission denied. Cannot start classification.");
    //   // You might want to yield an error into the stream or throw an exception
    //   throw Exception("Microphone permission denied.");
    //   // Alternatively, return an empty stream:
    //   // yield* const Stream<List<ClassificationResult>>.empty();
    //   // return;
    // }
    //
    // // 2. Ensure the SoundClassifier model is loaded
    // // It's good practice to load it before starting the stream
    // print("5");
    // try {
    //   print("6");
    //   await soundClassifier.loadModel();
    //   print("7");
    // } catch (e) {
    //   print("Failed to load TFLite model: $e");
    //   throw Exception("Failed to load sound classification model.");
    // }
    //
    // // 3. Set up the stream controller
    // print("8");
    // _classificationController = StreamController<List<ClassificationResult>>.broadcast(); // Use broadcast if multiple listeners are possible
    // _isRecording = true;
    // _audioBuffer = []; // Clear buffer on start
    //
    // print("9");
    // // Yield the stream immediately so the caller can start listening
    // yield* _classificationController!.stream;
    // print("10");
    //
    // // 4. Start Audio Recording Stream
    // // Configure audio recording to match YAMNet's requirements (16kHz, mono, 16-bit PCM)
    // final requiredBytesPerChunk = SoundClassifier.requiredInputSamples; // 2 bytes per sample for 16-bit PCM
    //
    // print("11");
    // try {
    //   print("12");
    //   final stream = await _audioRecorder.startStream(
    //     RecordConfig(
    //       encoder: AudioEncoder.pcm16bits, // 16-bit PCM
    //       sampleRate: SoundClassifier.requiredInputSamples, // 16kHz
    //       numChannels: 1,                 // Mono
    //     ),
    //   );
    //   print("12");
    //
    //   // 5. Listen to Audio Stream, Buffer, and Process Chunks
    //   stream.listen(
    //         (audioChunkBytes) {
    //           if (!_isRecording || _classificationController!.isClosed) {
    //         // Stop processing if recording is stopped or controller is closed
    //         return;
    //       }
    //       _audioBuffer.addAll(audioChunkBytes);
    //
    //       // Process buffer in chunks of the required size
    //       while (_audioBuffer.length >= requiredBytesPerChunk) {
    //         // Extract a chunk of the exact required size
    //         final chunkToClassify = Uint8List.fromList(_audioBuffer.sublist(0, requiredBytesPerChunk));
    //
    //         // Remove the processed chunk from the buffer
    //         _audioBuffer.removeRange(0, requiredBytesPerChunk);
    //
    //         // Classify the chunk asynchronously using the SoundClassifier
    //         // Use .then() or async/await within the listen callback carefully
    //         // to avoid blocking the stream. processing should be fast or offloaded.
    //         soundClassifier.runInference(chunkToClassify).then((rawResults) {
    //           if (!_classificationController!.isClosed) {
    //             // Map raw results (List<Map>) to Domain entities (List<ClassificationResult>)
    //             final classificationResults = rawResults.map((r) =>
    //                 ClassificationResult(
    //                   category: r['category'] as String,
    //                   confidence: r['confidence'] as double,
    //                 )
    //             ).toList();
    //
    //             // Add the results to the stream
    //             _classificationController!.add(classificationResults);
    //           }
    //
    //         }).catchError((error) {
    //           // Handle errors during classification
    //           print('Error classifying chunk: $error');
    //           if (!_classificationController!.isClosed) {
    //             _classificationController!.addError(error);
    //           }
    //         });
    //       }
    //     },
    //     onError: (error) {
    //       print('Audio stream error: $error');
    //       if (!_classificationController!.isClosed) {
    //         _classificationController!.addError(error);
    //       }
    //       stopContinuousClassification(); // Attempt to stop cleanly on stream error
    //     },
    //     onDone: () {
    //       print('Audio stream done.');
    //       stopContinuousClassification(); // Stop when the audio stream naturally ends (unlikely for mic)
    //     },
    //   );
    //
    // } catch (e) {
    //   // Handle errors starting the audio stream itself
    //   print('Error starting audio stream: $e');
    //   if (_classificationController != null && !_classificationController!.isClosed) {
    //     _classificationController!.addError(e);
    //   }
    //   stopContinuousClassification(); // Attempt to stop cleanly
    //   throw e; // Rethrow for the caller (e.g., Use Case) to handle
    // }
    //
    // // The async* function yields the stream and then the listener runs
    // // in the background, adding events to the stream.
  }

  Future<void> startClassification() async {
    if (_isRecording) return;
    _isRecording = true;

    // 1) Permission
    if (!await requestMicrophonePermission()) {
      _classificationController!.addError("Microphone permission denied");
      stopContinuousClassification(); return;
    }

    // 2) Load model
    try {
      await soundClassifier.loadModel();
    } catch (e) {
      _classificationController!.addError("Model load failed: $e");
      stopContinuousClassification(); return;
    }

    // 3) Start recorder
    final chunkBytes = SoundClassifier.requiredInputSamples * 2;
    try {
      final audioStream = await _audioRecorder.startStream(
        RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: SoundClassifier.requiredInputSamples,
          numChannels: 1,
        ),
      );

      audioStream.listen((bytes) => _processChunk(bytes, chunkBytes),
          onError: (e) { _classificationController!.addError(e); stopContinuousClassification(); },
          onDone: stopContinuousClassification);
    } catch (e) {
      _classificationController!.addError("Recorder start failed: $e");
      stopContinuousClassification();
    }
  }

  void _processChunk(Uint8List bytes, int chunkSize) {
    if (!_isRecording) return;
    _audioBuffer.addAll(bytes);
    while (_audioBuffer.length >= chunkSize) {
      final chunk = Uint8List.fromList(_audioBuffer.sublist(0, chunkSize));
      _audioBuffer.removeRange(0, chunkSize);
      soundClassifier.runInference(chunk).then((raw) {
        final results = raw.map((r) =>
            ClassificationResult(category: r['category'], confidence: r['confidence'])
        ).toList();
        _classificationController?.add(results);
      }).catchError((e) => _classificationController?.addError(e));
    }
  }



  @override
  Future<void> stopContinuousClassification() async {
    if (!_isRecording) {
      print("Classification not started, nothing to stop.");
      return;
    }
    _isRecording = false;
    _audioBuffer = []; // Clear any remaining buffered data

    // Stop the audio recorder
    try {
      if (await _audioRecorder.isRecording()) { // Check if it's actually recording
        await _audioRecorder.stop();
        print("Audio recording stopped.");
      }
    } catch (e) {
      print("Error stopping audio recorder: $e");
      // Continue stopping other resources
    }


    // Close the stream controller
    if (_classificationController != null && !_classificationController!.isClosed) {
      try {
        await _classificationController!.close();
        print("Classification stream controller closed.");
      } catch (e) {
        print("Error closing classification stream controller: $e");
      }
    }
    _classificationController = null; // Clear the controller reference


    // Optionally dispose the sound classifier if its lifecycle is tied to the repository
    // This depends on how you manage dependencies. If the repository is a singleton
    // for the app lifecycle, you might dispose the classifier in a higher-level dispose method.
    // _soundClassifier.dispose();
  }

  // Add a dispose method to the repository itself for cleanup when the repository instance is no longer needed
  void dispose() {
    print("Disposing SoundRecognitionRepositoryImpl");
    stopContinuousClassification(); // Ensure recording and stream are stopped
    soundClassifier.dispose(); // Dispose the classifier when the repository is disposed
    // No need to dispose _audioRecorder here, the 'record' package documentation
    // suggests stop() is sufficient cleanup for streams started with startStream.
    // Check the specific library's documentation for final confirmation.
  }

  @override
  Stream<double> getDecibelStream() {
    return localDataSource.decibelStream();
  }

  @override
  Future<bool> requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }
}