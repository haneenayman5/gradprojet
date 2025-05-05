// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
// import 'package:untitled/features/sound_detection/domain/usecases/monitor_sound.dart';
//
// // -------------------------
// // Cubit States
// // -------------------------
// @immutable
// abstract class SoundMonitorState {}
//
// class SoundMonitorInitial extends SoundMonitorState {}
//
// class SoundMonitorRunning extends SoundMonitorState {
//   final double dbLevel;
//   SoundMonitorRunning({required this.dbLevel});
// }
//
// class SoundMonitorError extends SoundMonitorState {
//   final String message;
//   SoundMonitorError({required this.message});
// }
//
// // -------------------------
// // SoundMonitorCubit
// // -------------------------
// class SoundMonitorCubit extends Cubit<SoundMonitorState> {
//   final MonitorSound monitorSound;
//   Stream<double>? _stream;
//
//   SoundMonitorCubit({required this.monitorSound})
//       : super(SoundMonitorInitial());
//
//   /// Starts listening to the decibel stream and emits new states.
//   void startMonitoring() {
//     if (_stream != null) return; // already listening
//     _stream = monitorSound.call();
//     _stream!.listen(
//           (db) => emit(SoundMonitorRunning(dbLevel: db)),
//       onError: (error) => emit(SoundMonitorError(message: error.toString())),
//     );
//   }
//
//   /// Stops monitoring and resets state.
//   void stopMonitoring() {
//     emit(SoundMonitorInitial());
//     _stream = null;
//   }
// }
//
