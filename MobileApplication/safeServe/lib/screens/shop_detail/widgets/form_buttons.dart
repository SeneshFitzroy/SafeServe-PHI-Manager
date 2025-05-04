import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../h800_form/h800_form_data.dart';

class FormButtons extends StatelessWidget {
  final String shopId;   // ← pass from ShopDetailScreen
  const FormButtons({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildFormButton(context, 'HC 800'),
          _buildFormButton(context, 'Sandeshaya'),
          _buildFormButton(context, 'Bond Form'),
        ],
      ),
    );
  }

  Widget _buildFormButton(BuildContext ctx, String label) => InkWell(
    onTap: () {
      if (label == 'HC 800') {
        Navigator.pushNamed(ctx, '/h800_form_screen_one', arguments: {
          'shopId': shopId,
          'phiId': FirebaseAuth.instance.currentUser!.uid,
          'formData': H800FormData(),
        });
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF21AED7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    ),
  );
}
