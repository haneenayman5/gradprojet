// import 'package:untitled3/features/sound_detection/domain/repositories/sound_repository.dart';
//
// /// Use-case: monitors the ambient sound level in decibels.
// /// Returns a [Stream] of `double` values representing real-time dB levels.
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:untitled3/features/sound_detection/domain/usecases/monitor_sound.dart';
//
// part 'sound_monitor_states.dart';
//
// /// Cubit that emits real-time decibel levels for the UI gauge.
// class SoundMonitorCubit extends Cubit<SoundMonitorState> {
//   final MonitorSound monitorSound;
//   Stream<double>? _subscription;
//
//   SoundMonitorCubit({required this.monitorSound})
//       : super(SoundMonitorInitial());
//
//   /// Starts listening to the decibel stream and emits new states.
//   void startMonitoring() {
//     if (_subscription != null) return; // already listening
//     _subscription = monitorSound.call();
//     _subscription!.listen(
//           (db) => emit(SoundMonitorRunning(dbLevel: db)),
//       onError: (error) => emit(SoundMonitorError(message: error.toString())),
//     );
//   }
//
//   /// Stops monitoring and resets state.
//   void stopMonitoring() {
//     // There's no direct cancel on Stream<double>, but if it's a broadcast stream you could cancel subscription
//     emit(SoundMonitorInitial());
//     _subscription = null;
//   }
// }