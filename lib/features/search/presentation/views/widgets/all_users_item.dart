import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/core/util/styles.dart';
import 'package:untitled3/features/video_home/domain/entity/ConversationEntity.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/story_item.dart';

class AllUsersItem extends StatelessWidget {
  const AllUsersItem(
      {super.key,
      required this.name,
      required this.senderId,
      required this.receiverId});
  final ConversationEntity name;
  final String senderId;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 20,
          contentPadding: EdgeInsets.zero,
          onTap: () {
            GoRouter.of(context).push(AppRoute.kChatPath, extra: name);
          },
          leading: const StoryItem(
            size: 40,
            sizeImage: 40,
          ),
          title: Text(
            name.otherUserId,
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: kCarosFont,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).push(
                    AppRoute.videoChatTestPath,
                    extra: {
                      'username1': senderId,
                      'username2': receiverId,
                    },
                  );
                },
                icon: const Icon(
                  Icons.videocam_rounded,
                  color: kNotifyColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.phone_rounded,
                  color: kNotifyColor,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: kContainerColor,
          indent: 75,
          endIndent: 10,
        )
      ],
    );
  }
}
