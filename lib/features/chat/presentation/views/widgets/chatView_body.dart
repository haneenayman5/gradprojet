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
  final formKey1 = GlobalKey<FormState>();
  final controller = ScrollController();
  final textEditingController = TextEditingController();

  late ChatBloc _chatBloc;
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

    Future.delayed(const Duration(milliseconds: 300), () {
      if (controller.hasClients) {
        controller.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
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
                  Expanded(
                    child: BlocConsumer<ChatBloc, ChatState>(
                      listener: (context, state) {
                        // Auto-scroll to latest message
                        if (state is ChatMessagesLoadingSuccess || state is ChatUpdating) {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            if (controller.hasClients) {
                              controller.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is ChatLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is ChatMessagesLoadingSuccess || state is ChatUpdating) {
                          final messages = state is ChatMessagesLoadingSuccess
                              ? state.messages
                              : (state as ChatUpdating).messages;
                          return ChatListview(
                            controller: controller,
                            messages: messages.map((e) => e.message).toList(),
                            name: widget.receiverId,
                            time: messages.map((e) => e.time).toList(),
                            senderIds: messages.map((e) => e.sender).toList(),
                            currentUserId: widget.senderId,
                          );
                        } else if (state is ChatMessagesLoadingFailure) {
                          return Center(child: Text("Error loading messages: ${state.error}"));
                        }
                        return const Center(child: Text("No messages yet"));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: CustomTextfield(
                      controller: textEditingController,
                      onSubmitted: (data) {
                        if (formKey1.currentState!.validate()) {
                          _sendMessage(data);
                        }
                      },
                      onChanged: (value) => text = value,
                      onTap: () {
                        if (formKey1.currentState!.validate() &&
                            text != null &&
                            text!.trim().isNotEmpty) {
                          _sendMessage(text!.trim());
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
