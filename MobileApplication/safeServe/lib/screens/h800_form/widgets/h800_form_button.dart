// lib/screens/h800_form/widgets/h800_form_button.dart
import 'package:flutter/material.dart';

class H800FormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const H800FormButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF1F41BB)),
            ),
            child: Text(
              label, // Use the provided label
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F41BB),
              ),
            ),
          ),
        ),
      ),
    );
  }
}