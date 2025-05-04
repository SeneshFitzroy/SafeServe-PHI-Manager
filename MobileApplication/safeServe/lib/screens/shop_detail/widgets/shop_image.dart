import 'package:flutter/material.dart';

class ShopImage extends StatelessWidget {
  final String imagePath;
  const ShopImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4289FC)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        clipBehavior: Clip.hardEdge,
        child: _img(),
      ),
    );
  }

  Widget _img() {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, __, ___) =>
            Image.asset('assets/images/other/placeholder.jpg',
                fit: BoxFit.cover, width: double.infinity),
      );
    } else if (imagePath.isNotEmpty) {
      return Image.asset(imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (_, __, ___) =>
              Image.asset('assets/images/other/placeholder.jpg',
                  fit: BoxFit.cover, width: double.infinity));
    }
    return Image.asset('assets/images/other/placeholder.jpg',
        fit: BoxFit.cover, width: double.infinity);
  }
}
