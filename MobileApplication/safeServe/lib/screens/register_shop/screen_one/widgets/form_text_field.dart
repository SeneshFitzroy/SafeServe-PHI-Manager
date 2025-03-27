import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final bool isInvalid;
  final String initialValue;
  final TextInputType inputType;
  final ValueChanged<String> onChanged;

  const FormTextField({
    super.key,
    required this.label,
    required this.isInvalid,
    required this.initialValue,
    required this.onChanged,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialValue);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8), // Reduced vertical padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 18, color: Colors.black)),
          const SizedBox(height: 6), // Reduce space between label and input field
          SizedBox(
            height: 42,
            child: TextField(
              controller: controller,
              keyboardType: inputType,
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Adjusted padding
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Slightly smaller border
                  borderSide: BorderSide(
                    color: isInvalid ? Colors.red : const Color(0xFF4289FC),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isInvalid ? Colors.red : const Color(0xFF4289FC),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
