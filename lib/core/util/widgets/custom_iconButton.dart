import 'package:flutter/material.dart';
import 'package:untitled3/core/constants/constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed, this.color, this.iconSize, this.size, this.background, 
  });
  final IconData icon;
  final void Function()? onPressed;
  final Color? color,background;
  final double? iconSize,size;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ??55,
      width: size ??55,
      decoration: BoxDecoration(
          color: background ??kContainerColor, shape: BoxShape.circle),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: iconSize??30,
            color: color ?? Colors.white,
          )),
    );
  }
}
