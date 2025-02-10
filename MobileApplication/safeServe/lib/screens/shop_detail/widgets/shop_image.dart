// lib/screens/shop_detail/widgets/shop_image.dart
import 'package:flutter/material.dart';

class ShopImage extends StatelessWidget {
  final String imagePath;

  const ShopImage({Key? key, required this.imagePath}) : super(key: key);

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
