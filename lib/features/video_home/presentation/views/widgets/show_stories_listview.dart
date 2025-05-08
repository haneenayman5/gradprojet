import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/custom_category.dart';

class ShowStoriesListview extends StatelessWidget {
  const ShowStoriesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomCategory(
        onTap: () {
          GoRouter.of(context).push(AppRoute.kSearchPath);
        },
        iconData: Icons.search,
        title: "Search",
        backgroundColor: kContainerColor,
        textColor: Colors.white,
        width: MediaQuery.of(context).size.width * 0.95,
      ),
    );
  }
}