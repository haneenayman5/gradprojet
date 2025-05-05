import 'dart:async';

import 'package:untitled3/features/sound_detection/domain/repositories/sound_repository.dart';

class StopSoundClassificationUseCase {
  final SoundRepository _repository;

  StopSoundClassificationUseCase(this._repository);

  Future<void> call() {
    return _repository.stopContinuousClassification();
  }
}