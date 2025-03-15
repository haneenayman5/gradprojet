import 'package:untitled3/features/chat/data/models/message.dart';

class ChatMessageEntity {
  final String sender;
  final String receiver;
  final String message;
  final DateTime time;

  ChatMessageEntity({required this.receiver, required this.time, required this.sender, required this.message});

  ChatMessageEntity.fromModel(ChatMessageEntity model):
        sender = model.sender,
        receiver = model.receiver,
        message = model.message,
        time = model.time;
}
