// lib/screens/register_shop/screen_two/widgets/bottom_buttons.dart
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;

  const BottomButtons({
    Key? key,
    required this.onPrevious,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // right side
        children: [
          InkWell(
            onTap: onPrevious,
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF1F41BB)),
              ),
              child: const Text(
                'Previous',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F41BB)),
              ),
            ),
          ),
          InkWell(
            onTap: onSubmit,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF1F41BB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
