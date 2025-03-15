import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/chat/domain/entities/message.dart';
import 'package:untitled3/features/chat/presentation/blocs/chat_bloc.dart';
import 'package:untitled3/features/chat/presentation/blocs/chat_events.dart';
import 'package:untitled3/features/chat/presentation/blocs/chat_states.dart';

class ChatPage extends StatefulWidget {
  final String senderId;
  final String receiverId;

  const ChatPage({
    super.key,
    required this.senderId,
    required this.receiverId,
  });

  @override createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController _messageController;
  late List<ChatMessageEntity> _messages = <ChatMessageEntity>[];
  late ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _chatBloc = BlocProvider.of<ChatBloc>(context);

    _chatBloc.add(ChatLoadMessages(sender: widget.senderId, receiver: widget.receiverId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _chatBloc.add(ChatDisconnect());
    super.dispose();
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      final message = ChatMessageEntity(
        sender: widget.senderId,
        receiver: widget.receiverId,
        message: messageText,
        time: DateTime.now(),
      );
      _chatBloc.add(ChatSendMessage(message: message));
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatMessagesLoadingSuccess) {
                  return ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return ListTile(
                        title: Text(msg.message),
                        subtitle: Text("From: ${msg.sender} at ${msg.time}"),
                      );
                    },
                  );
                } else if (state is ChatMessagesLoadingFailure) {
                  return Center(child: Text("Error loading the messages: ${state.error}"));
                }
                else if (state is ChatUpdating) {
                  return ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final ChatMessageEntity msg = _messages[index];
                      return ListTile(
                        title: Text(msg.message),
                        subtitle: Text("From: ${msg.sender} at ${msg.time}"),
                      );
                    },
                  );
                }
                return const Center(child: Text("No messages yet"));
              },
              listener: (context, state) {
                if(state is ChatMessagesLoadingSuccess) {
                  for (var model in state.messages) {
                    _messages.add(ChatMessageEntity.fromModel(model));
                  }
                } else if(state is ChatAddingMessage) {
                    _messages.add(state.message);
                    _chatBloc.add(ChatUpdateMessages());
                    print(_messages);
                  }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: "Enter your message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
