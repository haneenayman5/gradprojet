import '../entities/classification_result.dart';

abstract class SoundRepository {
  Stream<double> getDecibelStream(); // for dB gauge
  Stream<List<ClassificationResult>> detectSoundEvents(); // identifies sound types
  Future<void> stopContinuousClassification();
  Future<bool> requestMicrophonePermission();
}
