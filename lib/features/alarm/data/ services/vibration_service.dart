abstract class VibrationService {
  Future<void> vibratePattern(List<int> pattern, {List<int>? intensities});
}