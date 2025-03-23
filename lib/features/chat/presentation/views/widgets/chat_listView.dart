import 'package:flutter/material.dart';
import 'package:untitled3/features/chat/presentation/views/widgets/chatAnother_container.dart';
import 'package:untitled3/features/chat/presentation/views/widgets/chat_container.dart';

class ChatListview extends StatelessWidget {
  const ChatListview({
    super.key,
    required this.controller,
    required this.messages, required this.name, required this.time,
  });
  final ScrollController controller;
  final List<String> messages;
  final String name ;
  final String myName = 'mo';
  final List <DateTime> time;
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        reverse: true,
        controller: controller,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return 
          myName != name ?
           ChatContainer(
            text: messages[index] ,
            time:time[index],
          ):ChatanotherContainer(text: messages[index], time: time[index]);
        },
      ),
    );
  }
}
