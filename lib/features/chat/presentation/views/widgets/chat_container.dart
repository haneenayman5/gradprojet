import 'package:flutter/material.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/util/styles.dart';
import '../../../../../utils/date_formatter.dart'; // Import the helper

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    super.key,
    required this.text,
    required this.time,
    required this.senderId,
    required this.currentUserId,
  });

  final String text;
  final DateTime time;
  final String senderId;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentUser = senderId == currentUserId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCurrentUser ? 'You' : senderId,
            style: Styles.textStyle14.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kContainerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Text(
              text,
              style: Styles.textStyle16.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            formatDateTime(time, now),
            style: Styles.textStyle14.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}





