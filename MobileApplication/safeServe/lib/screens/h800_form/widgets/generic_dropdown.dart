// lib/screens/h800_form/widgets/generic_dropdown.dart - for my reference
import 'package:flutter/material.dart';

class GenericDropdown extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool isInvalid;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const GenericDropdown({
    super.key,
    required this.label,
    required this.initialValue,
    this.isInvalid = false,
    required this.items,
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
          DropdownButtonFormField<String>(
            value: initialValue.isEmpty ? null : initialValue,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (val) => onChanged(val ?? ''),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isInvalid ? Colors.red : Colors.grey,
                ),
              ),
            ),
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