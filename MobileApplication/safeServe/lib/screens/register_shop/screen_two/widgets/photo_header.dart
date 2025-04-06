// lib/screens/register_shop/screen_two/widgets/photo_header.dart
import 'package:flutter/material.dart';

class PhotoHeader extends StatelessWidget {
  final String title;
  final VoidCallback onArrowPressed;

  const PhotoHeader({
    super.key,
    required this.title,
    required this.onArrowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          InkWell(
            onTap: onArrowPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFCDE6FE),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: Color(0xFF1F41BB)),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
