import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled3/core/util/styles.dart';

class CustomCategory extends StatelessWidget {
  const CustomCategory({
    super.key,
    required this.onTap,
    required this.title,
    required this.backgroundColor,
    required this.textColor, required this.width,
  });
  final Color backgroundColor, textColor;
  final void Function() onTap;
  final String title;
  final double width;
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
        child: Center(
          child: Text(
            title,
            style: Styles.textStyle18.copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
