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
          _buildFormButton(
            context,
            'HC 800',
                () => Navigator.pushNamed(context, '/h800_form_screen'),
          ),
          _buildFormButton(
            context,
            'Sandeshaya',
                () {
              // TODO: wire this one up
            },
          ),
          _buildFormButton(
            context,
            'Bond Form',
                () {
              // TODO: wire this one up
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormButton(
      BuildContext context,
      String label,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF21AED7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
