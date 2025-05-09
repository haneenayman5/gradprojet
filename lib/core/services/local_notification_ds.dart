// import 'dart:async';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:uuid/uuid.dart';
//
// /// Data source that wraps the FlutterLocalNotificationsPlugin to schedule and
// /// cancel system notifications for alarms.
// class LocalNotificationDataSource {
//   final FlutterLocalNotificationsPlugin _plugin;
//
//   /// Stream controller that emits the notification id when the alarm fires.
//   final StreamController<int> _alarmFiredController = StreamController<int>.broadcast();
//
//   LocalNotificationDataSource(this._plugin) {
//     _initialize();
//   }
//
//   /// Exposes a stream of notification IDs for when alarms fire.
//   Stream<int> get onAlarmFired => _alarmFiredController.stream;
//
//   /// Initializes the plugin and sets up callbacks.
//   Future<void> _initialize() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings(); // Replaces IOSInitializationSettings
//     const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
//
//     await _plugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         final payload = response.payload;
//         if (payload != null) {
//           final id = int.tryParse(payload);
//           if (id != null) {
//             _alarmFiredController.add(id);
//           }
//         }
//       },
//     );
//   }
//
//
//   /// Schedules a one-time or repeating notification based on [repeatPattern].
//   Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'alarm_channel',
//       'Alarms',
//       channelDescription: 'Channel for scheduled alarms',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: false, // disable sound for deaf users
//       enableVibration: false, // vibration handled separately
//     );
//     const platformDetails = NotificationDetails(android: androidDetails);
//
//     await _plugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledTime, tz.local),
//       platformDetails,
//       payload: id.toString(),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }
//
//   /// Cancels a scheduled notification by id.
//   Future<void> cancelNotification({required int id}) async {
//     await _plugin.cancel(id);
//     // also cancel any weekday variants
//     for (var weekday = DateTime.monday; weekday <= DateTime.friday; weekday++) {
//       await _plugin.cancel(id + weekday);
//     }
//   }
//
//   Future<int> _nextNotificationId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final current = prefs.getInt('next_notification_id') ?? 0;
//     final next = (current + 1) & 0x7fffffff;  // wrap within 32 bits
//     await prefs.setInt('next_notification_id', next);
//     return next;
//   }
//
//   /// Dispose resources when no longer needed.
//   void dispose() {
//     _alarmFiredController.close();
//   }
// }

import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationDataSource {
  final FlutterLocalNotificationsPlugin _plugin;
  final StreamController<String?> _tapController = StreamController.broadcast();

  LocalNotificationDataSource(this._plugin) {
    _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (response) {
        _tapController.add(response.payload);
      },
    );
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationDetails? details,
  }) {
    return _plugin.show(id, title, body, details ?? _defaultDetails(), payload: payload);
  }

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
    NotificationDetails? details,
  }) {
    return _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details ?? _defaultDetails(),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancel(int id) => _plugin.cancel(id);

  Stream<String?> get onNotificationTapped => _tapController.stream;

  NotificationDetails _defaultDetails() {
    const android = AndroidNotificationDetails(
      'default_channel', 'General',
      channelDescription: 'General notifications',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const iOS = DarwinNotificationDetails();
    return const NotificationDetails(android: android, iOS: iOS);
  }
}