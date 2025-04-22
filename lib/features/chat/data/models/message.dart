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
    DateTime date = DateTime.parse(rawDate).toLocal();
    print("raw dateeeee: ${rawDate}");
    print("local dateeeee: ${date.toString()}");
    return ChatMessageModel(
      sender: json['sender'] as String? ?? "",
      receiver: json['receiver'] as String? ?? "",
      message: json['content'] as String? ?? "",
      time: DateTime.parse(json['msgDate'] as String? ?? "").toLocal(),
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
