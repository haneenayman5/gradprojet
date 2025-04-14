import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime, DateTime now) {
  final localDateTime = dateTime.toLocal();
  final localNow = now.toLocal();

  final today = DateTime(localNow.year, localNow.month, localNow.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final aDate = DateTime(localDateTime.year, localDateTime.month, localDateTime.day);

  if (aDate == today) {
    return "Today · ${DateFormat('h:mm a').format(localDateTime)}";
  } else if (aDate == yesterday) {
    return "Yesterday · ${DateFormat('h:mm a').format(localDateTime)}";
  } else {
    return "${DateFormat('MMMM d').format(localDateTime)} · ${DateFormat('h:mm a').format(localDateTime)}";
  }
}

