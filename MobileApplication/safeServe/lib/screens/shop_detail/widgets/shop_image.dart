import 'package:flutter/material.dart';

class ShopImage extends StatelessWidget {
  final String imagePath;

  const ShopImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: 190,
          width: double.infinity,
        ),
    );
  }
}
