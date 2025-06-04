import 'package:equatable/equatable.dart';
import '../../domain/entity/ConversationEntity.dart';

abstract class ChatHomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatHomeInitial extends ChatHomeState {}

class ChatHomeLoadingConversations extends ChatHomeState {}

class ChatHomeLoadingConversationsSuccessful extends ChatHomeState {
  final List<ConversationEntity> conversations;
  final String senderId;

  ChatHomeLoadingConversationsSuccessful({
    required this.conversations,
    required this.senderId,
  });

  @override
  List<Object?> get props => [conversations, senderId];
}

class ChatConversationsLoadingFailure extends ChatHomeState {
  final String error;

  ChatConversationsLoadingFailure({required this.error});

  @override
  List<Object?> get props => [error];
}