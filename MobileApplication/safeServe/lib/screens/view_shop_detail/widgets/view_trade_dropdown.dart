import 'package:flutter/material.dart';

class ViewTradeDropdown extends StatelessWidget {
  final String label;
  final String value;
  const ViewTradeDropdown({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  static const _options = <String>[
    'Restaurants',
    'Eateries',
    'Bakeries',
    'Hotels',
    'Cafés',
    'Mobile Food Carts',
    'Street Vendors',
    'Supermarkets',
    'Fast‑Food Outlets',
    'Catering Services',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border:
            Border.all(color: const Color(0xFF4289FC)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _options.contains(value) ? value : null,
              isExpanded: true,
              items: _options
                  .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                  .toList(),
              onChanged: null,
              hint: Text(value.isEmpty ? 'Not specified' : value),
              iconDisabledColor: Colors.grey,
            ),
          ),
        ),
      ]),
    );
  }
}
