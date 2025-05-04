import 'package:flutter/material.dart';

class RadioButtonField extends StatelessWidget {
  final String label;
  final String? value; // Changed to String? to align with H800FormData
  final bool isInvalid;
  final ValueChanged<String?> onChanged;

  const RadioButtonField({
    super.key,
    required this.label,
    required this.value,
    this.isInvalid = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Radio<String?>(
                value: 'Yes',
                groupValue: value,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
              const Text('Yes'),
              const SizedBox(width: 20),
              Radio<String?>(
                value: 'No',
                groupValue: value,
                onChanged: onChanged,
                activeColor: Colors.red,
              ),
              const Text('No'),
            ],
          ),
          if (isInvalid)
            const Text(
              'This field is required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
        ],
      ),
    );
  }
}