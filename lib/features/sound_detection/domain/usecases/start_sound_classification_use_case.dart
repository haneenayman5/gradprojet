import 'dart:async';

import 'package:untitled3/features/sound_detection/domain/repositories/sound_repository.dart';

import '../entities/classification_result.dart';

class StartSoundClassificationUseCase {
  final SoundRepository _repository;

  StartSoundClassificationUseCase(this._repository);

  Stream<List<ClassificationResult>> call() {
    // The Use Case simply calls the repository method
    return _repository.detectSoundEvents();
  }
}