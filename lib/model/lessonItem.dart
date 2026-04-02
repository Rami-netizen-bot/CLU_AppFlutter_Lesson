import 'package:flutter/material.dart';

class LessonItem {
  final int number;
  final String title;
  final String description;
  final Widget page;

  const LessonItem({
    required this.number,
    required this.title,
    required this.description,
    required this.page,
  });
}