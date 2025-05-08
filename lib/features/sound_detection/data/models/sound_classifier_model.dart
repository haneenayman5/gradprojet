import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle; // Needed for rootBundle
import 'dart:typed_data';
import 'dart:math'; // For min

class SoundClassifier {
  late Interpreter _interp;
  late List<String> _labels;
  bool _isLoaded = false; // Add a flag

  static const int _sampleRate = 16000;
  static const int _inputLength = 15600; // YAMNet expects 15600 samples (~0.975 s)
  static const int _outputSize = 521; // YAMNet output size (number of classes)
  static const double _threshold = 0.3; // Example confidence threshold

  // Add a public static getter for the required input samples
  static int get requiredInputSamples => _inputLength;

  // Add a public static getter for the required input bytes (16-bit PCM is 2 bytes/sample)
  static int get requiredInputBytes => _inputLength * 2;

  Future<void> loadModel() async {
    if (_isLoaded) return; // Prevent reloading
    try {
      print('Loading model...');
      _interp = await Interpreter.fromAsset('assets/models/yamnet.tflite');
      print('Model loaded successfully');
      final rawLabels = await rootBundle.loadString('assets/models/yamnet_label_list.txt');
      _labels = rawLabels.split('\n').where((label) => label.isNotEmpty).toList(); // Filter empty lines
      print('Labels loaded successfully: ${_labels.length}');
      if (_labels.length != _outputSize) {
        print('Warning: Label count does not match model output size! Model: $_outputSize, Labels: ${_labels.length}');
      }
      _isLoaded = true;
    } catch (e) {
      print('Error loading model or labels: $e');
      _isLoaded = false;
      rethrow; // Re-throw the error for upstream handling
    }
  }

  // Method to run inference on a raw audio chunk (PCM 16-bit, 16kHz mono)
  // YAMNet expects Float32 input [1, 15600]
  Future<List<Map<String, dynamic>>> runInference(Uint8List audioChunk) async {
    if (!_isLoaded) {
      throw StateError('Model not loaded. Call loadModel() first.');
    }
    final expectedBytes = _inputLength * 2; // 16-bit PCM is 2 bytes per sample
    if (audioChunk.length != expectedBytes) {
      // Handle incorrect size as before
      print('Warning: Audio chunk size (${audioChunk.length} bytes) does not match expected size (${expectedBytes} bytes) for ${SoundClassifier._inputLength} samples.');
      return [];
    }

    // Conversion and normalization logic remains the same using standard Dart typed data
    final int16List = Int16List.view(audioChunk.buffer);
    final float32List = Float32List(_inputLength);
    for (int i = 0; i < _inputLength; i++) {
      if (i < int16List.length) {
        float32List[i] = int16List[i] / 32768.0; // 2^15
      } else {
        float32List[i] = 0.0;
      }
    }

    // Prepare input tensor [1, 15600]
    final input = [float32List];

    // Prepare output tensor [1, 521]
    final outputBuffer = List<List<double>>.filled(1, List<double>.filled(_outputSize, 0.0));

    try {
      // _interp.run is part of tflite_flutter
      _interp.run(input, outputBuffer);
    } catch (e) {
      print('Error during TFLite inference: $e');
      return []; // Return empty list on inference error
    }

    // Manual processing of the output buffer remains the same
    final List<double> probabilities = outputBuffer[0];
    final List<Map<String, dynamic>> results = [];

    for (int i = 0; i < min(probabilities.length, _labels.length); i++) {
      if (probabilities[i] > _threshold) {
        results.add({
          'category': _labels[i],
          'confidence': probabilities[i],
        });
      }
    }

    results.sort((a, b) => b['confidence'].compareTo(a['confidence']));

    return results;
  }

  void dispose() {
    if (_isLoaded) {
      _interp.close();
      _isLoaded = false;
      print('SoundClassifier disposed.');
    }
  }
}