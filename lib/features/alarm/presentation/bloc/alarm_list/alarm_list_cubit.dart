import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/alarm_entity.dart';
import '../../../domain/repositories/alarm_repository.dart';

part 'alarm_list_state.dart';

/// Manages CRUD for scheduled alarms
class AlarmListCubit extends Cubit<AlarmListState> {
  final AlarmRepository repository;

  AlarmListCubit({required this.repository}) : super(AlarmListInitial());

  Future<void> loadAlarms() async {
    try {
      emit(AlarmListLoading());
      final alarms = await repository.getAllAlarms();
      emit(AlarmListLoaded(alarms: alarms));
    } catch (e) {
      emit(AlarmListError(message: e.toString()));
    }
  }

  Future<void> addAlarm(Alarm alarm) async {
    await repository.scheduleAlarm(alarm);
    await loadAlarms();
  }

  Future<void> removeAlarm(int id) async {
    await repository.cancelAlarm(id);
    await loadAlarms();
  }

  Future<void> updateAlarm(Alarm alarm) async {
    await repository.cancelAlarm(alarm.id);
  }
}