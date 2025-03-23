import 'package:flutter/material.dart';
import 'package:untitled3/core/util/assets.dart';

import 'package:cached_network_image/cached_network_image.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, this.sizeImage, this.size});
  final double? sizeImage, size;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: size ?? 30,
          child: CircleAvatar(
            radius: sizeImage ?? 27,
            backgroundColor: Colors.amber,
          ),
        ));
  }
}
