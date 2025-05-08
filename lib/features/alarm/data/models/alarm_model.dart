import 'dart:convert';

import 'package:untitled3/features/alarm/domain/entities/flash_data.dart';
import 'package:untitled3/features/alarm/domain/entities/vibration_data.dart';

import '../../domain/entities/alarm_entity.dart';
import '../../domain/entities/week_day.dart';

/// Data Transfer Object for persisting and retrieving Alarm data.
class AlarmModel {
  final int id;
  final bool isEnabled;
  final String label;
  final String time; // ISO8601 string
  final Map<String, dynamic> vibrationData;
  final Map<String, dynamic> flashData;
  final List<String> repeatDays;

  AlarmModel({
    required this.id,
    required this.label,
    required this.time,
    required this.vibrationData,
    required this.flashData,
    required this.repeatDays,
    required this.isEnabled,
  });

  /// Converts a domain [Alarm] to an [AlarmModel] for storage.
  factory AlarmModel.fromDomain(Alarm alarm) {
    return AlarmModel(
      id: alarm.id,
      label: alarm.label,
      time: alarm.time.toIso8601String(),
      vibrationData: alarm.vibrationData.toJson(),
      flashData: alarm.flashData.toJson(),
      repeatDays: alarm.repeatDays.map((d) => d.name).toList(),
      isEnabled: alarm.isEnabled,
    );
  }

  /// Converts this model into a domain [Alarm] entity.
  Alarm toDomain() {
    return Alarm(
      id: id,
      label: label,
      time: DateTime.parse(time),
      vibrationData: VibrationData.fromJson(
        vibrationData,
      ),
      flashData: FlashData.fromJson(
        flashData,
      ),
      repeatDays: repeatDays.map(WeekDayX.fromName).toList(),
      isEnabled: isEnabled
    );
  }

  /// Serializes this model to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'time': time,
      'vibrationData': vibrationData,
      'flashData': flashData,
      'isEnabled': isEnabled,
      'repeatDays': repeatDays,
    };
  }

  /// Constructs an [AlarmModel] from JSON.
  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'] as int,
      label: json['label'] as String,
      time: json['time'] as String,
      vibrationData: Map<String, dynamic>.from(json['vibrationData'] as Map),
      flashData: Map<String, dynamic>.from(json['flashData'] as Map),
      repeatDays: List<String>.from(json['repeatDays'] as List),
      isEnabled: json['isEnabled'],
    );
  }
}
