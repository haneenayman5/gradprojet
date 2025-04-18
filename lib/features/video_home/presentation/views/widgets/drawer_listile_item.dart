import 'package:flutter/material.dart';
import 'package:untitled3/core/util/styles.dart';

class DrawerListileItem extends StatelessWidget {
  const DrawerListileItem(
      {super.key, required this.icon, required this.title, });
  final Widget icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 25,
                ),
                Text(
                  title,
                  style: Styles.textStyle18.copyWith(color: Colors.white),
                ),
              ],
            ),
    );
  }
}
