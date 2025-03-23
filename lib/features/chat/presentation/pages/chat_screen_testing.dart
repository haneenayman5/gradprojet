//this screen is for testing purposes only

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/features/chat/presentation/views/chat_view.dart';
import 'chat_screen.dart'; // Make sure this file exports ChatPage

class ChatTestScreen extends StatefulWidget {
  const ChatTestScreen({Key? key}) : super(key: key);

  @override
  _ChatTestScreenState createState() => _ChatTestScreenState();
}

class _ChatTestScreenState extends State<ChatTestScreen> {
  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _receiverController = TextEditingController();

  void _startChat() {
    final sender = _senderController.text.trim();
    final receiver = _receiverController.text.trim();

    if (sender.isEmpty || receiver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Both sender and receiver IDs are required."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to the chat screen, passing the sender and receiver IDs.
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => ChatView(senderId: sender, receiverId: receiver),
    //     // builder: (_) => ChatPage(senderId: sender, receiverId: receiver),
    //   ),
    // );

    context.go(AppRoute.kChatPath, extra: {
      'senderId': sender,
      'receiverId': receiver
    });
  }

  @override
  void dispose() {
    _senderController.dispose();
    _receiverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Test Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _senderController,
              decoration: const InputDecoration(
                labelText: "Enter Sender ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _receiverController,
              decoration: const InputDecoration(
                labelText: "Enter Receiver ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _startChat,
              child: const Text("Start Chat"),
            ),
          ],
        ),
      ),
    );
  }
}
