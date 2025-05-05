import 'package:untitled3/features/sound_detection/domain/repositories/sound_repository.dart';

/// Use-case: monitors the ambient sound level in decibels.
/// Returns a [Stream] of `double` values representing real-time dB levels.
class MonitorSoundUsecase {
  final SoundRepository repository;

  MonitorSoundUsecase(this.repository);

  /// Executes the use-case.
  ///
  /// 
  /// Returns a stream of decibel levels emitted by the underlying repository.
  Stream<double> call() {
    return repository.getDecibelStream();
  }
}
