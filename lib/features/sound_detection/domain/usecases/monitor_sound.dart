import 'dart:math';

import 'package:untitled3/features/sound_detection/domain/repositories/sound_repository.dart';

abstract class MonitorSoundUsecase {
  SoundRepository get repository;

  Stream<double> call();
}

class RealMonitorSound implements MonitorSoundUsecase {
  @override
  final SoundRepository repository;

  RealMonitorSound({required this.repository});

  @override
  Stream<double> call() {
    return repository.getDecibelStream();
  }
}

class FakeMonitorSound implements MonitorSoundUsecase {
  @override
  Stream<double> call() async* {
    final rnd = Random();
    while (true) {
      // generate a value between 30 and 90 dB
      await Future.delayed(const Duration(milliseconds: 200));
      var val = 30 + rnd.nextDouble() * 60;
      yield val;
    }
  }

  @override
  // TODO: implement repository
  SoundRepository get repository => throw UnimplementedError();
}
