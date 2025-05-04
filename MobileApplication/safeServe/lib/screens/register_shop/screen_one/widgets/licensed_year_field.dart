// lib/screens/register_shop/screen_one/widgets/licensed_year_field.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LicensedYearField extends StatefulWidget {
  final String label;
  final bool isInvalid;
  final String initialValue;
  final ValueChanged<String> onDatePicked;

  const LicensedYearField({
    super.key,
    required this.label,
    required this.isInvalid,
    required this.initialValue,
    required this.onDatePicked,
  });

  @override
  State<LicensedYearField> createState() => _LicensedYearFieldState();
}

class _LicensedYearFieldState extends State<LicensedYearField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime initialDate = DateTime.now();
    if (widget.initialValue.isNotEmpty) {
      // parse date if possible
      try {
        initialDate = DateFormat('yyyy-MM-dd').parse(widget.initialValue);
      } catch (_) {}
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        _controller.text = formatted;
      });
      widget.onDatePicked(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor =
    widget.isInvalid ? Colors.red : const Color(0xFF4289FC);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.label, style: const TextStyle(fontSize: 18, color: Colors.black)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _pickDate,
          child: AbsorbPointer(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}