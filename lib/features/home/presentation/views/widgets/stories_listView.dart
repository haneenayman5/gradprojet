import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/features/home/presentation/views/widgets/story_item.dart';

class StoriesListview extends StatelessWidget {
  const StoriesListview({super.key});
 
  @override
  Widget build(BuildContext context) {
    List<String> names = [
    'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
   'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
    'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
  ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 10),
        itemCount: names.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRoute.kChatPath,extra: names[index]);
              },
              child: const StoryItem());
        },
      ),
    );
  }
}
