import 'package:flutter/material.dart';

class FormButtons extends StatelessWidget {
  const FormButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildFormButton('HC 800'),
          _buildFormButton('Form 1'),
          _buildFormButton('Form 2'),
        ],
      ),
    );
  }

  Widget _buildFormButton(String label) {
    return InkWell(
      onTap: () {
        // Navigate to the form screen
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF21AED7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
