import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled3/core/services/local_notification_ds.dart';


class AlarmNotificationService{
  final LocalNotificationDataSource localNotificationDataSource;

  AlarmNotificationService(this.localNotificationDataSource);

  static NotificationDetails _alarmDetails() {
    const android = AndroidNotificationDetails(
      'alarm_channel', 'Alarms',
      channelDescription: 'Channel for scheduled alarms',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      enableVibration: false,
    );
    const iOS = DarwinNotificationDetails(presentSound: false);
    return const NotificationDetails(android: android, iOS: iOS);
  }

  Future<void> scheduleAlarmNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) {
    return localNotificationDataSource.schedule(
      id: id,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      details: _alarmDetails(),
      payload: id.toString(),
    );
  }

  Future<void> cancelAlarmNotification(int id) =>
      localNotificationDataSource.cancel(id);

  Stream<int> get onAlarmFired => localNotificationDataSource.onNotificationTapped
      .map((payload) {
    if (payload == null) throw StateError('Missing payload on alarm');
    final parsed = int.tryParse(payload);
    if (parsed == null) throw FormatException('Invalid alarm ID payload: $payload');
    return parsed;
  });
}
