import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled3/core/util/styles.dart';

class CustomCategory extends StatelessWidget {
  const CustomCategory({
    super.key,
    required this.onTap,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.width,
    this.iconData,
  });
  final Color backgroundColor, textColor;
  final void Function() onTap;
  final String title;
  final double width;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: textColor,
              ),
            const SizedBox(width: 5),
            Text(
              title,
              style: Styles.textStyle18.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
