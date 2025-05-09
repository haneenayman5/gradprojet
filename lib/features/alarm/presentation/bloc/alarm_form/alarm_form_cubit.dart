import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/alarm_entity.dart';
import '../../../domain/entities/flash_data.dart';
import '../../../domain/entities/vibration_data.dart';
import '../../../domain/entities/week_day.dart';
import 'alarm_form_state.dart';

class AlarmFormCubit extends Cubit<AlarmFormState> {
  /// If [initialAlarm] is provided, we're editing; otherwise create a new one.
  AlarmFormCubit({Alarm? initialAlarm})
      : super(
    AlarmFormState(
      alarm: initialAlarm ??
          Alarm(
            id: DateTime.now().millisecondsSinceEpoch,
            label: '',
            time: DateTime.now(),
            repeatDays: List<WeekDay>.empty(),
            vibrationData: VibrationData(hasVibration: false),
            flashData: FlashData(hasFlash: false),
            isEnabled: false,
          ),
      isValid: initialAlarm != null
          ? _validate(initialAlarm)
          : false,
    ),
  );

  /// Update the alarm’s time and re-validate.
  void updateTime(DateTime newTime) {
    var newAlarm = state.alarm.copyWith(time: newTime);
    _emit(newAlarm);
  }

  /// Update the repeat days list and re-validate.
  void updateRepeat(List<WeekDay> newDays) {
    //state.alarm.repeatDays = newDays.map((d) => WeekDayX.fromShortName(d)).toList();
    var newAlarm = state.alarm.copyWith(repeatDays: newDays);
    _emit(newAlarm);
  }

  // … other updateX methods …

  void _emit(Alarm updatedAlarm) {
    final valid = _validate(updatedAlarm);
    print("Alarm settings: \n "
        "Is enabled: ${updatedAlarm.isEnabled} \n"
        "Repeat days: ${updatedAlarm.repeatDays} \n"
        "Time: ${updatedAlarm.time}\n"
        "Label: ${updatedAlarm.label}\n"
        "Vibration data: not yet implemented\n"
        "Flash data: not yet implemented");
    emit(state.copyWith(alarm: updatedAlarm, isValid: valid));
  }

  static bool _validate(Alarm alarm) {
    return alarm.time.isAfter(DateTime.now());
  }
}
