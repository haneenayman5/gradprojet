import 'package:equatable/equatable.dart';
import 'package:untitled3/features/chat/domain/entities/message.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {

}

class ChatMessagesLoadingSuccess extends ChatState {
  final List<ChatMessageEntity> messages;

  ChatMessagesLoadingSuccess({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class ChatMessagesLoadingFailure extends ChatState {
  final String error;

  ChatMessagesLoadingFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ChatAddingMessage extends ChatState {
  final ChatMessageEntity message;

  ChatAddingMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatInitial extends ChatState {
}

class ChatUpdating extends ChatState {

}