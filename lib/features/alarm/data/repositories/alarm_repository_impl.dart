import 'dart:async';

import 'package:untitled3/features/alarm/domain/entities/alarm_entity.dart';
import 'package:untitled3/features/alarm/domain/entities/flash_data.dart';
import 'package:untitled3/features/alarm/domain/entities/vibration_data.dart';

import '../../domain/repositories/alarm_repository.dart';
import '../datasources/local_alarm_data_source.dart';
import '../datasources/local_notification_ds.dart';
import '../models/alarm_model.dart';

/// Concrete implementation of [AlarmRepository], wiring domain alarms to
/// platform notification APIs and optional IoT light flashes.
class AlarmRepositoryImpl implements AlarmRepository {
  final LocalNotificationDataSource notifications;
  final LocalAlarmDataSource localAlarmDataSource;

  // Controller for triggering AlarmEvents when alarms fire
  final StreamController<Alarm> _controller = StreamController.broadcast();

  AlarmRepositoryImpl({
    required this.notifications,
    required this.localAlarmDataSource
  }) {
    // Listen to the native notification callbacks
    notifications.onAlarmFired.listen(_onNativeAlarmFired);
  }

  @override
  Future<void> scheduleAlarm(Alarm alarm) async {
    // Schedule a system notification at the given time
    await localAlarmDataSource.addAlarm(AlarmModel.fromDomain(alarm));
    await notifications.scheduleNotification(
      id: alarm.id,
      title: alarm.label ?? 'Alarm',
      body: 'Alarm for ${alarm.time}',
      scheduledTime: alarm.time,
    );
  }

  @override
  Future<void> updateAlarm(Alarm alarm) async {
    await localAlarmDataSource.updateAlarm(AlarmModel.fromDomain(alarm));

    await notifications.cancelNotification(id: alarm.id);
    await notifications.scheduleNotification(
      id: alarm.id,
      title: alarm.label ?? 'Alarm',
      body: 'Alarm for ${alarm.time}',
      scheduledTime: alarm.time,
    );
  }

  @override
  Future<void> cancelAlarm(int alarmId) async {
    await localAlarmDataSource.deleteAlarm(alarmId);
    // Cancel system notification
    await notifications.cancelNotification(id: alarmId);
  }

  @override
  Stream<Alarm> onAlarmTriggered() => _controller.stream;

  void _onNativeAlarmFired(int notificationId) async{
    // Map notificationId back to our Alarm id
    // Note: we used hashCode above, so reverse mapping may require lookup
    final alarmModel = await localAlarmDataSource.getAlarmById(notificationId);
    if (alarmModel == null) {
      print("⚠️ No alarm found for notification ID: $notificationId");
      return;
    }
    _controller.add(alarmModel.toDomain());
  }

  //todo: make sure this is called
  void dispose() {
    _controller.close();
    notifications.dispose();
  }

  @override
  Future<List<Alarm>> getAllAlarms() async {
    // 1) Load the stored AlarmModels
    final models = await localAlarmDataSource.loadAlarms();

    // 2) Map to domain Alarms
    final alarms = models.map((m) => m.toDomain()).toList();

    // 3) (Optional) you might want to keep them sorted by time
    alarms.sort((a, b) => a.time.compareTo(b.time));

    return alarms;
  }
}
