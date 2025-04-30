import 'package:flutter/material.dart';

class Course {
  final String title;
  final String subtitle;
  final String image;
  final Color bgcolor;
  final String? extraImage;

  Course({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.bgcolor,
    this.extraImage,
  });
}
