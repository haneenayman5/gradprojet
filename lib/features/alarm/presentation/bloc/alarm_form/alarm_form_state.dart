// alarm_form_state.dart
part of 'alarm_form_cubit.dart';

@immutable
class AlarmFormState extends Equatable {

  @override
  List<Object?> get props => [];
}

/// Initial form state with a default or empty Alarm instance.
class AlarmFormInitial extends AlarmFormState {}

class AlarmFormUpdate extends AlarmFormState {
  final AlarmFormData alarmData;

  AlarmFormUpdate({required this.alarmData});

  @override
  List<Object?> get props => [alarmData];
}
// final Alarm alarm;
//
// const AlarmFormState({required this.alarm});
//
// /// Creates a new state by updating only the provided fields on the Alarm.
// AlarmFormState copyWith({
// Alarm? alarm,
// }) {
// return AlarmFormState(
// alarm: alarm ?? this.alarm,
// );
// }
//
// @override
// List<Object?> get props => [alarm];