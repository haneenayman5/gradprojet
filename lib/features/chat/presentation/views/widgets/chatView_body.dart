import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/chat/presentation/views/widgets/chat_listView.dart';
import 'package:untitled3/features/chat/presentation/views/widgets/custom_appBarChat.dart';
import 'package:untitled3/features/chat/presentation/views/widgets/custom_textField.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entities/message.dart';
import '../../blocs/chat_bloc.dart';
import '../../blocs/chat_events.dart';
import '../../blocs/chat_states.dart';

class ChatviewBody extends StatefulWidget {
  final String senderId;
  final String receiverId;

  const ChatviewBody({
    super.key,
    required this.senderId,
    required this.receiverId,
  });

  @override
  State<ChatviewBody> createState() => _ChatviewBodyState();
}

class _ChatviewBodyState extends State<ChatviewBody> {
  final GlobalKey<FormState> formKey1 = GlobalKey();
  final ScrollController controller = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  late ChatBloc _chatBloc;
  final List<ChatMessageEntity> _messages = <ChatMessageEntity>[];

  String? text;

  @override
  void initState() {
    super.initState();
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _chatBloc.add(ChatLoadMessages(sender: widget.senderId, receiver: widget.receiverId));
  }

  @override
  void dispose() {
    controller.dispose();
    textEditingController.dispose();
    _chatBloc.add(ChatDisconnect());
    super.dispose();
  }

  void _sendMessage(String data) {
    final message = ChatMessageEntity(
      sender: widget.senderId,
      receiver: widget.receiverId,
      message: data,
      time: DateTime.now(),
    );

    _chatBloc.add(ChatSendMessage(message: message));
    textEditingController.clear();

    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey1,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    child: Divider(color: kContainerColor, thickness: 4),
                  ),
                  const SizedBox(height: 15),
                  CustomAppbarChat(name: widget.receiverId),
                  const SizedBox(height: 20),

                  /// Bloc Builder to handle chat state
                  BlocConsumer<ChatBloc, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ChatMessagesLoadingSuccess || state is ChatUpdating) {
                        final messages = _messages.map((msg) => msg.message).toList();
                        final times = _messages.map((msg) => msg.time).toList();
                        final senderIds = _messages.map((msg) => msg.sender).toList();

                        return ChatListview(
                          controller: controller,
                          messages: messages,
                          name: widget.receiverId,
                          time: times,
                          senderIds: senderIds,
                          currentUserId: widget.senderId,
                        );
                      } else if (state is ChatMessagesLoadingFailure) {
                        return Center(child: Text("Error loading messages: ${state.error}"));
                      }
                      return const Center(child: Text("No messages yet"));
                    },
                    listener: (context, state) {
                      if (state is ChatMessagesLoadingSuccess) {
                        _messages.clear();
                        for (var model in state.messages) {
                          _messages.add(ChatMessageEntity.fromModel(model));
                        }
                      } else if (state is ChatAddingMessage) {
                        _messages.insert(0, state.message);
                        _chatBloc.add(ChatUpdateMessages());
                      }
                    },
                  ),

                  /// Chat input field
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: 15,
                      top: 20,
                    ),
                    child: CustomTextfield(
                      controller: textEditingController,
                      onSubmitted: (data) {
                        if (formKey1.currentState!.validate()) {
                          _sendMessage(data);
                        }
                      },
                      onChanged: (value) {
                        text = value;
                      },
                      onTap: () {
                        if (formKey1.currentState!.validate() && text != null && text!.isNotEmpty) {
                          _sendMessage(text!);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
