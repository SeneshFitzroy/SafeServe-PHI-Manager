import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../h800_form/h800_form_data.dart';

class FormButtons extends StatelessWidget {
  final String shopId;
  const FormButtons({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _btn('HC 800', () {
          final phi = FirebaseAuth.instance.currentUser!;
          Navigator.pushNamed(
            context,
            '/h800_form_screen',
            arguments: {
              'formData': H800FormData(),
              'shopId'  : shopId,
              'phiId'   : phi.uid,
            },
          );
        }),
        _btn('Sandeshaya', () {}),
        _btn('Bond Form',  () {}),
      ],
    ),
  );

  Widget _btn(String label, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF21AED7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}
