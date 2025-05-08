import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.iconSize,
    this.size,
    this.background,
  });
  final IconData icon;
  final void Function()? onPressed;
  final Color? color, background;
  final double? iconSize, size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 55,
      width: size ?? 55,
      decoration: BoxDecoration(
        // add decoration properties if needed, like color or borderRadius
        color: Colors.blue, // example color
        shape: BoxShape.circle, // example shape
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: iconSize ?? 30,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
