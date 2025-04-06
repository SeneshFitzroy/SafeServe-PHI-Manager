// lib/screens/register_shop/screen_two/widgets/photo_preview.dart
import 'dart:io';
import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  final String? photoPath;
  final bool isMissing;
  final VoidCallback onTap;

  const PhotoPreview({
    super.key,
    required this.photoPath,
    required this.isMissing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isMissing ? Colors.red : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 460,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: photoPath == null ? Colors.grey[400] : null,
            border: Border.all(color: borderColor, width: 3),
          ),
          child: (photoPath == null)
              ? const Center(
                  child: Text(
                    'Tap to take photo',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(photoPath!),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
