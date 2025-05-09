import 'package:untitled3/features/alarm/domain/entities/flash_data.dart';
import 'package:untitled3/features/alarm/domain/entities/vibration_data.dart';
import 'package:untitled3/features/alarm/domain/entities/week_day.dart';

class Alarm {
  final int id;
  final List<WeekDay> repeatDays;
  final String label;
  final bool isEnabled;
  final DateTime time;
  final VibrationData vibrationData;
  final FlashData flashData;

  const Alarm({
    required this.id,
    required this.repeatDays,
    required this.label,
    required this.isEnabled,
    required this.time,
    required this.vibrationData,
    required this.flashData,
  });

  Alarm copyWith({
    int? id,
    List<WeekDay>? repeatDays,
    String? label,
    bool? isEnabled,
    DateTime? time,
    VibrationData? vibrationData,
    FlashData? flashData,
  }) {
    return Alarm(
      id: id ?? this.id,
      repeatDays: repeatDays ?? List<WeekDay>.from(this.repeatDays),
      label: label ?? this.label,
      isEnabled: isEnabled ?? this.isEnabled,
      time: time ?? this.time,
      vibrationData: vibrationData ?? this.vibrationData,
      flashData: flashData ?? this.flashData,
    );
  }
}
