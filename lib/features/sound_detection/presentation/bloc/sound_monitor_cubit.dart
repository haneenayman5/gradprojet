// sound_monitor_cubit.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/sound_detection/domain/entities/classification_result.dart';
import 'package:untitled3/features/sound_detection/domain/usecases/monitor_sound.dart';
import 'package:untitled3/features/sound_detection/domain/usecases/start_sound_classification_use_case.dart';
import 'package:untitled3/features/sound_detection/domain/usecases/stop_sound_classification_use_case.dart';
import 'sound_monitor_states.dart';

class SoundMonitorCubit extends Cubit<SoundMonitorState> {
  final MonitorSoundUsecase monitorNoise;
  final StartSoundClassificationUseCase startClassification;
  final StopSoundClassificationUseCase stopClassification;

  StreamSubscription<double>? _noiseSub;
  StreamSubscription<List<ClassificationResult>>? _classSub;

  double _dbLevel = 0.0;
  List<ClassificationResult> _classes = [];

  SoundMonitorCubit({
    required this.monitorNoise,
    required this.startClassification,
    required this.stopClassification,
  }) : super(SoundMonitorInitial());

  /// Kick off both noise & classification streams
  void startMonitoring() {
    _startNoise();
    _startClassification();
  }

  void _startNoise() {
    if (_noiseSub != null) return;
    _noiseSub = monitorNoise().listen(
          (db) {
        _dbLevel = db;
        _emitRunning();
      },
      onError: (e) => emit(SoundMonitorError(message: e.toString())),
    );
  }

  void _startClassification() {
    if (_classSub != null) return;
    _classSub = startClassification().listen(
          (classes) {
        _classes = classes;
        _emitRunning();
      },
      onError: (e) => emit(SoundMonitorError(message: e.toString())),
    );
  }

  void _emitRunning() {
    emit(SoundMonitorRunning(
      dbLevel: _dbLevel,
      soundEvents: _classes.map((c) => c.category).toList(),
    ));
  }

  /// Cancel both streams and emit initial state
  Future<void> stopMonitoring() async {
    await _noiseSub?.cancel();
    _noiseSub = null;

    await _classSub?.cancel();
    _classSub = null;

    stopClassification(); // tell your use-case to tear down any resources
    emit(SoundMonitorInitial());
  }

  @override
  Future<void> close() {
    _noiseSub?.cancel();
    _classSub?.cancel();
    return super.close();
  }
}
