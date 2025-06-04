import 'package:untitled3/features/chat/domain/entities/message.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required super.sender,
    required super.receiver,
    required super.message,
    required super.time,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    String rawDate = json['msgDate'] as String? ?? "";

    // Check if rawDate already has timezone info
    bool hasTimeZone = rawDate.endsWith('Z') || rawDate.contains('+') || rawDate.contains('-');

    // Append 'Z' if missing timezone info to treat as UTC
    String dateString = hasTimeZone ? rawDate : '$rawDate' + 'Z';

    DateTime date = DateTime.parse(dateString).toLocal();

    print("raw date: $rawDate");
    print("parsed date (local): $date");

    return ChatMessageModel(
      sender: json['sender'] as String? ?? "",
      receiver: json['receiver'] as String? ?? "",
      message: json['content'] as String? ?? "",
      time: date,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'time': time.toIso8601String(),
    };
  }
}
