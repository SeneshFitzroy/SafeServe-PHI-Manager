import 'package:flutter/material.dart';

class TradeDropdown extends StatefulWidget {
  final String label;
  final bool isInvalid;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const TradeDropdown({
    super.key,
    required this.label,
    required this.isInvalid,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<TradeDropdown> createState() => _TradeDropdownState();
}

class _TradeDropdownState extends State<TradeDropdown> {
  final List<String> _tradeOptions = [
    'Restaurants',
    'Eateries',
    'Bakeries',
    'Hotels',
    'Cafés',
    'Mobile Food Carts'
  ];
  String? _selectedTrade;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue.isNotEmpty && _tradeOptions.contains(widget.initialValue)) {
      _selectedTrade = widget.initialValue;
    } else {
      _selectedTrade = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.isInvalid ? Colors.red : const Color(0xFF4289FC),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedTrade,
                hint: const Text('Select Trade'),
                isExpanded: true,
                items: _tradeOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTrade = value;
                    widget.onChanged(value ?? '');
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}