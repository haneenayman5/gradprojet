import 'package:flutter/material.dart';
import 'package:untitled3/features/chat/presentation/views/widgets/chatView_body.dart';

class ChatView extends StatelessWidget {
  final String senderId;
  final String receiverId;
  const ChatView({super.key, required this.senderId, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ChatviewBody(senderId: senderId, receiverId: receiverId,),
    );
  }
}
