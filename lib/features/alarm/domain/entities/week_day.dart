enum WeekDay {
  saturday, sunday, monday, tuesday, wednesday, thursday, friday
}

extension WeekDayX on WeekDay {
  /// Short label for UI chips
  String get shortName {
    switch (this) {
      case WeekDay.monday:    return 'Mo';
      case WeekDay.tuesday:   return 'Tu';
      case WeekDay.wednesday: return 'We';
      case WeekDay.thursday:  return 'Th';
      case WeekDay.friday:    return 'Fr';
      case WeekDay.saturday:  return 'Sa';
      case WeekDay.sunday:    return 'Su';
    }
  }

  /// For JSON (e.g. “monday”)
  String get name => toString().split('.').last;

  static WeekDay fromName(String name) =>
      WeekDay.values.firstWhere((d) => d.name == name);
}
