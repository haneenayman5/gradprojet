import 'package:flutter/material.dart';
import 'package:untitled3/features/search/presentation/views/widgets/all_users_item.dart';
import 'package:untitled3/features/video_home/domain/entity/ConversationEntity.dart';

class AllUsersListview extends StatelessWidget {
  const AllUsersListview(
      {super.key,
      required this.names,
      required this.senderId,
      required this.receiverId});
  final List<ConversationEntity> names;
  final String senderId;
  final String receiverId;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: names.length,
      itemBuilder: (context, index) {
        return AllUsersItem(
          senderId: senderId,
          receiverId: receiverId,
          name: names[index],
        );
      },
    );
  }
}
