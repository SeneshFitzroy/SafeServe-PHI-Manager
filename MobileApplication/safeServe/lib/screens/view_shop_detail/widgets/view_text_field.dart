import 'package:flutter/material.dart';

class ViewTextField extends StatelessWidget {
  final String label;
  final String value;
  const ViewTextField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 18, color: Colors.black)),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: value),
          enabled: false,
          maxLines: value.length > 40 ? null : 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4289FC)),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ]),
    );
  }
}
