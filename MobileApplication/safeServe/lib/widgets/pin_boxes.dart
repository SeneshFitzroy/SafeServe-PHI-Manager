import 'package:flutter/material.dart';

class PinBoxes extends StatelessWidget {
  final TextEditingController controller;
  const PinBoxes({super.key, required this.controller});

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    maxLength: 6,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 24, letterSpacing: 18),
    decoration: const InputDecoration(
      counterText: '',
      enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1F41BB))),
      focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1F41BB), width: 2)),
    ),
  );
}
