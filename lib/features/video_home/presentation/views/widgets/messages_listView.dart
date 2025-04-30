import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/video_home/domain/entity/ConversationEntity.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_bloc.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_events.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_states.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/message_item.dart';

class MessagesListview extends StatefulWidget {
  const MessagesListview({super.key, required this.notify});
  final int notify;

  @override
  State<MessagesListview> createState() => _MessagesListviewState();
}

class _MessagesListviewState extends State<MessagesListview> {
  late String senderId;

  late ChatHomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ChatHomeBloc>(context);

    bloc.add(ChatHomeLoadConversation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatHomeBloc, ChatHomeState>(
      builder: (context, state) {
        if(state is ChatHomeInitial)
        {
          return const Center(child: CircularProgressIndicator());
        }
        else if(state is ChatHomeLoadingConversationsSuccessful)
        {
            final senderId = state.senderId;
          var names = state.conversations.map((c) => c.otherUserId).toList();
          var lastMessages = state.conversations.map((c) => c.lastMessage).toList();
          var lastMessagesTimes = state.conversations.map((c) => c.lastMessageTime).toList();
          var imageUrls = state.conversations.map((c) => c.otherUserPfpUrl).toList();
          return SizedBox(
            height: MediaQuery.of(context).size.height * ((names.length +1 )/10 ) ,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return MessageItem(
                    onDismissed: (direction) {
                      setState(() {
                        names.removeAt(index);
                      });
                    },
                    id: names[index],
                    senderId: senderId,
                    receiverId: names[index],
                    lastMessage: lastMessages[index],
                    lastMessageTime: lastMessagesTimes[index],
                    notify: widget.notify,
                    imageUrl: imageUrls[index],
                  );
                },
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
      listener: (context, state) {
        // if(state is ChatHomeLoadingConversationsSuccessful) {
        //   senderId = state.senderId;
        // }
      },
    );
  }
}
