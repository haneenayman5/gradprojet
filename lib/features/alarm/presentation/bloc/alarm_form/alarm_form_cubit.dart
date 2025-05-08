// alarm_form_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../forms/alarm_form_data.dart';

part 'alarm_form_state.dart';

/// Manages state for alarm creation/edit form
class AlarmFormCubit extends Cubit<AlarmFormState> {
  AlarmFormCubit() : super(AlarmFormInitial());

  void updateAlarm(AlarmFormData alarmData) {
    emit(AlarmFormUpdate(alarmData: alarmData));
  }
}