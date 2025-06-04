import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_bloc.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_events.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_states.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/message_item.dart';

class MessagesListview extends StatefulWidget {
  final int notify;

  const MessagesListview({super.key, required this.notify});

  @override
  State<MessagesListview> createState() => _MessagesListviewState();
}

class _MessagesListviewState extends State<MessagesListview>
    with AutomaticKeepAliveClientMixin {
  late ChatHomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ChatHomeBloc>(context);
    bloc.add(ChatHomeLoadConversation());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Important for AutomaticKeepAliveClientMixin
    return BlocBuilder<ChatHomeBloc, ChatHomeState>(
      builder: (context, state) {
        if (state is ChatHomeInitial || state is ChatHomeLoadingConversations) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatHomeLoadingConversationsSuccessful) {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView.builder(
              itemCount: state.conversations.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final conversation = state.conversations[index];
                return MessageItem(
                  id: conversation.otherUserId,
                  senderId: state.senderId,
                  receiverId: conversation.otherUserId,
                  lastMessage: conversation.lastMessage,
                  lastMessageTime: conversation.lastMessageTime,
                  notify: widget.notify,
                  imageUrl: conversation.otherUserPfpUrl,
                  onDismissed: (direction) {
                    setState(() {
                      state.conversations.removeAt(index);
                    });
                  },
                );
              },
            ),
          );
        } else if (state is ChatConversationsLoadingFailure) {
          return Center(child: Text("Error: ${state.error}"));
        }
        return const Center(child: Text("No conversations available"));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
