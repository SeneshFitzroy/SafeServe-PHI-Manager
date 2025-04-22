import 'package:flutter/material.dart';

class ViewShopHeader extends StatelessWidget {
  final String title;
  final VoidCallback onArrowPressed;

  const ViewShopHeader({
    Key? key,
    required this.title,
    required this.onArrowPressed,
  }) : super(key: key);

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
              child:
              const Icon(Icons.arrow_back_rounded, color: Color(0xFF1F41BB)),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}