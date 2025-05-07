import 'package:untitled3/features/alarm/domain/entities/flash_data.dart';
import 'package:untitled3/features/alarm/domain/entities/vibration_data.dart';
import 'package:untitled3/features/alarm/domain/entities/week_day.dart';

class Alarm {
  final int id;
  List<WeekDay> repeatDays;
  String label;
  bool isEnabled;
  DateTime time;
  VibrationData vibrationData;
  FlashData flashData;

  Alarm({
    required this.id,
    required this.label,
    required this.time,
    required this.vibrationData,
    required this.flashData,
    required this.isEnabled,
    required this.repeatDays,

  });

}