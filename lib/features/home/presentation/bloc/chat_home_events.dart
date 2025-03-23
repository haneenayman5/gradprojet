import 'package:equatable/equatable.dart';

abstract class ChatHomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatHomeLoadConversation extends ChatHomeEvent {

  ChatHomeLoadConversation();

}