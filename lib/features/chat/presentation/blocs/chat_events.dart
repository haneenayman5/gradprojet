import 'package:equatable/equatable.dart';
import 'package:untitled3/features/chat/domain/entities/message.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatMessageReceived extends ChatEvent {
  final ChatMessageEntity message;

  ChatMessageReceived({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatSendMessage extends ChatEvent {
  final ChatMessageEntity message;

  ChatSendMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatLoadMessages extends ChatEvent {
  final String sender;
  final String receiver;

  ChatLoadMessages({required this.sender, required this.receiver});

  @override
  List<Object?> get props => [sender, receiver];
}

class ChatConnect extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class ChatDisconnect extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class ChatUpdateMessages extends ChatEvent { //after a new message is received or something like that

}