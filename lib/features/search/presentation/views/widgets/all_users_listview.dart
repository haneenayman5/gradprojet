import 'package:flutter/material.dart';
import 'package:untitled3/features/search/presentation/views/widgets/all_users_item.dart';

class AllUsersListview extends StatelessWidget {
  const AllUsersListview({super.key, required this.names});
 final  List<String> names ;
  @override
  Widget build(BuildContext context) {
   
    return SliverList.builder(

      itemCount: names.length,
      itemBuilder: (context, index) {
        return AllUsersItem(
          name: names[index],
        );
      },
    );
  }
}
