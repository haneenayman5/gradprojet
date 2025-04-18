import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/core/util/widgets/custom_iconButton.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/stories_listview.dart';

class ShowStoriesListview extends StatelessWidget {
  const ShowStoriesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children:  [
          const SizedBox(
            width: 35,
          ),
          CustomIconButton(
            icon: Icons.search,
            onPressed: (){
GoRouter.of(context).push(AppRoute.kSearchPath);
            },
          ),
           const StoriesListview(),
        ],
      ),
    );
  }
}