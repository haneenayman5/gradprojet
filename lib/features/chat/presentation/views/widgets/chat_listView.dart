import 'package:flutter/material.dart';
import 'package:untitled3/features/chat/presentation/views/widgets/chatAnother_container.dart';
import 'package:untitled3/features/chat/presentation/views/widgets/chat_container.dart';

class ChatListview extends StatelessWidget {
  const ChatListview({
    super.key,
    required this.controller,
    required this.messages,
    required this.name,
    required this.time,
    required this.senderIds,
    required this.currentUserId,
  });

  final ScrollController controller;
  final List<String> messages;
  final List<DateTime> time;
  final List<String> senderIds; // List of senderIds per message
  final String name; // conversation partner name
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        reverse: true,
        controller: controller,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final senderId = senderIds[index];

          // If the message was sent by the current user
          if (senderId == currentUserId) {
            return ChatAnotherContainer(
              text: messages[index],
              time: time[index],
              senderId: senderId,
              currentUserId: currentUserId,
            );
          } else {
            return ChatContainer(
              text: messages[index],
              time: time[index],
              senderId: senderId,
              currentUserId: currentUserId,
            );
          }
        },
      ),
    );
  }
}




