// lib/widgets/grade_badge.dart
import 'package:flutter/material.dart';

class GradeBadge extends StatelessWidget {
  final String grade; // 'A', 'B', 'C', 'D'
  final double size;
  final double fontSize;

  static const Map<String, Color> _gradeColors = {
    'A': Color(0xFF3DB952),
    'B': Color(0xFFF1D730),
    'C': Color(0xFFFF8514),
    'D': Color(0xFFBB1F22),
  };

  const GradeBadge({
    Key? key,
    required this.grade,
    this.size = 40,
    this.fontSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = _gradeColors[grade] ?? Colors.grey;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        grade,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}
