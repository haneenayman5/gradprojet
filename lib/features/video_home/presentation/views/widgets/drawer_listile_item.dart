import 'package:flutter/material.dart';
import 'package:untitled3/core/util/styles.dart';
class DrawerListileItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback? onTap;

  const DrawerListileItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 30, top: 15),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              icon,
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
