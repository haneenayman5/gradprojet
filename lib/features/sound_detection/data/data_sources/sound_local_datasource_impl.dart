import 'dart:async';
import 'package:noise_meter/noise_meter.dart'; // For decibel
import 'sound_local_datasource.dart';
// import '../../domain/entities/sound_event.dart';

class SoundLocalDataSourceImpl implements SoundLocalDataSource {
  final NoiseMeter _noiseMeter = NoiseMeter();

  @override
  Stream<double> decibelStream() async* {
    await for (var noiseReading in _noiseMeter.noise) {
      yield noiseReading.meanDecibel;
    }
  }

  // @override
  // Stream<SoundEvent> soundEventStream() async* {
  //   // You'd integrate TensorFlow Lite or another model here to detect specific sounds
  //   // and map them to SoundEvent with confidence levels
  // }
}
