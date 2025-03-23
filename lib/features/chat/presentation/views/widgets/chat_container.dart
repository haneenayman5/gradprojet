import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/util/styles.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({super.key, required this.text, required this.time});
  final String text;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(
                  right: 15, top: 15, left: 15, bottom: 15),
              decoration: BoxDecoration(
                  color: kAnotherContainer,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
              child: Stack(
                children: [
                  Text(text,
                      style: Styles.textStyle16.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.done_all,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(DateFormat('h:mm a').format(time),
                    style: Styles.textStyle14.copyWith(
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
