import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/core/util/styles.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/story_item.dart';

class AllUsersItem extends StatelessWidget {
  const AllUsersItem({super.key, required this.name});
final String name;
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
            name,
            style: Styles.textStyle18.copyWith( fontWeight: FontWeight.w600, fontFamily: kCarosFont),
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
