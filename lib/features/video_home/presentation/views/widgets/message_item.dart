import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/core/util/styles.dart';
import 'package:untitled3/core/util/widgets/custom_iconButton.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/story_item.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.notify,
    required this.senderId,
    required this.receiverId,
    required this.id,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.imageUrl,
    this.onDismissed,
  });

  final int notify;
  final String senderId, receiverId, id;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String? imageUrl;
  final Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Dismissible(
        onDismissed: (direction) {
          if (onDismissed != null) onDismissed!(direction);
        },
        key: Key(id),
        secondaryBackground: Container(
          padding: const EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          decoration: const BoxDecoration(
            color: Colors.white10,
          ),
          child: const CustomIconButton(
            size: 40,
            iconSize: 25,
            background: kNotifyColor,
            icon: Icons.delete_rounded,
          ),
        ),
        background: Container(
          padding: const EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: const CustomIconButton(
            size: 40,
            iconSize: 25,
            background: kNotifyColor,
            icon: Icons.delete_rounded,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                GoRouter.of(context).push(AppRoute.kChatPath,
                  extra: {
                  'senderId': senderId,
                  'receiverId': receiverId,
                },
                );
              },
              leading: StoryItem(
                size: 40,
                sizeImage: 40,
                imageUrl: imageUrl?? "",
              ),
              title: Text(
                receiverId,
                style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: kCarosFont,
                ),
              ),
              subtitle: Text(
                lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle16,
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('h:mm').format(lastMessageTime),
                    style: Styles.textStyle16,
                  ),
                  notification(),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.videocam_rounded),
                    color: kNotifyColor,
                    tooltip: 'Start Video Chat',
                    onPressed: () {
                      GoRouter.of(context).push(
                        AppRoute.videoChatTestPath,
                        extra: {
                          'username1': senderId,
                          'username2': receiverId,
                        },
                      );
                    },
                  ),
                ],
              ),

            ),
            Divider(
              color: kContainerColor,
              indent: 110,
            )
          ],
        ),
      ),
    );
  }

  /// 📆 Updated to handle local time correctly
  String _formatMessageTime(DateTime messageTime, DateTime now) {
    final localMessageTime = messageTime.toLocal();
    final localNow = now.toLocal();

    final today = DateTime(localNow.year, localNow.month, localNow.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(
        localMessageTime.year, localMessageTime.month, localMessageTime.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yyyy').format(localMessageTime);
    }
  }

  Widget notification() {
    if (notify == 0) {
      return const SizedBox();
    } else {
      return Container(
        height: 25,
        width: 25,
        decoration:
            const BoxDecoration(color: kNotifyColor, shape: BoxShape.circle),
        child: Center(
          child: Text('$notify', style: Styles.textStyle14),
        ),
      );
    }
  }
}
