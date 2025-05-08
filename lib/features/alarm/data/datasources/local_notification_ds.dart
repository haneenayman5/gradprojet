import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

/// Data source that wraps the FlutterLocalNotificationsPlugin to schedule and
/// cancel system notifications for alarms.
class LocalNotificationDataSource {
  final FlutterLocalNotificationsPlugin _plugin;

  /// Stream controller that emits the notification id when the alarm fires.
  final StreamController<int> _alarmFiredController = StreamController<int>.broadcast();

  LocalNotificationDataSource(this._plugin) {
    _initialize();
  }

  /// Exposes a stream of notification IDs for when alarms fire.
  Stream<int> get onAlarmFired => _alarmFiredController.stream;

  /// Initializes the plugin and sets up callbacks.
  Future<void> _initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(); // Replaces IOSInitializationSettings
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null) {
          final id = int.tryParse(payload);
          if (id != null) {
            _alarmFiredController.add(id);
          }
        }
      },
    );
  }


  /// Schedules a one-time or repeating notification based on [repeatPattern].
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'alarm_channel',
      'Alarms',
      channelDescription: 'Channel for scheduled alarms',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false, // disable sound for deaf users
      enableVibration: false, // vibration handled separately
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformDetails,
      payload: id.toString(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  /// Cancels a scheduled notification by id.
  Future<void> cancelNotification({required int id}) async {
    await _plugin.cancel(id);
    // also cancel any weekday variants
    for (var weekday = DateTime.monday; weekday <= DateTime.friday; weekday++) {
      await _plugin.cancel(id + weekday);
    }
  }

  /// Helper to compute next instance for weekday repeat
  tz.TZDateTime _nextInstanceOfWeekday(DateTime base, int weekday) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, base.hour, base.minute);
    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// Dispose resources when no longer needed.
  void dispose() {
    _alarmFiredController.close();
  }
}
