import 'package:flutter/material.dart';
import 'package:untitled3/core/util/styles.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/story_item.dart';

class DrawerAppbar extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String email;

  const DrawerAppbar({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Scaffold.of(context).closeEndDrawer();
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
            const Spacer(flex: 1),
            Text(
              'Settings',
              style: Styles.textStyle18.copyWith(color: Colors.white),
            ),
            const Spacer(flex: 2),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StoryItem(imageUrl: imageUrl,),
            const Spacer(flex: 1),
            Text(name, style: Styles.textStyle18.copyWith(color: Colors.white)),
            const Spacer(flex: 2),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}


