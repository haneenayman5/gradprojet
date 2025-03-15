import 'package:untitled3/features/chat/domain/entities/message.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required super.sender,
    required super.receiver,
    required super.message,
    required super.time,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      sender: json['sender'] as String? ?? "",
      receiver: json['receiver'] as String? ?? "",
      message: json['content'] as String? ?? "",
      time: DateTime.parse(json['msgDate'] as String? ?? ""),
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
