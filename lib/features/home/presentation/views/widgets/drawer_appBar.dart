import 'package:flutter/material.dart';
import 'package:untitled3/core/util/styles.dart';
import 'package:untitled3/features/home/presentation/views/widgets/story_item.dart';

class DrawerAppbar extends StatelessWidget {
  const DrawerAppbar({super.key});

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
            const Spacer(
              flex: 1,
            ),
            Text(
              'Settings',
              style: Styles.textStyle18.copyWith(color: Colors.white),
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const StoryItem(),
            const Spacer(
              flex: 1,
            ),
            Text('Tom Brenan',
                style: Styles.textStyle18.copyWith(color: Colors.white)),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
