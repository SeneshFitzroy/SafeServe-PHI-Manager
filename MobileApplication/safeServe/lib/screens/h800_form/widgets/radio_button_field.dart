// lib/screens/h800_form/widgets/radio_button_field.dart -  - For my reference
import 'package:flutter/material.dart';

class RadioButtonField extends StatelessWidget {
  final String label;
  final bool value;
  final bool isInvalid;
  final ValueChanged<bool> onChanged;

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
              Radio<bool>(
                value: true,
                groupValue: value,
                onChanged: (val) => onChanged(true),
                activeColor: Colors.green,
              ),
              const Text('Yes'),
              const SizedBox(width: 20),
              Radio<bool>(
                value: false,
                groupValue: value,
                onChanged: (val) => onChanged(false),
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