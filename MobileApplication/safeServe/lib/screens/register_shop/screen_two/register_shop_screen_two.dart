// lib/screens/register_shop/screen_two/register_shop_screen_two.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/safe_serve_appbar.dart';
import 'widgets/photo_header.dart';
import 'widgets/photo_preview.dart';
import 'widgets/bottom_buttons.dart';
import '../register_shop_form_data.dart';

class RegisterShopScreenTwo extends StatefulWidget {
  final RegisterShopFormData formData;

  const RegisterShopScreenTwo({Key? key, required this.formData}) : super(key: key);

  @override
  State<RegisterShopScreenTwo> createState() => _RegisterShopScreenTwoState();
}

class _RegisterShopScreenTwoState extends State<RegisterShopScreenTwo> {
  bool _photoMissing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {
          // optional
        },
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Photo header
                PhotoHeader(
                  title: 'Photo Upload',
                  onArrowPressed: () => Navigator.pop(context), // back to screen 1
                ),
                const SizedBox(height: 20),
                // Photo preview
                PhotoPreview(
                  photoPath: widget.formData.photoPath,
                  isMissing: _photoMissing,
                  onTap: _takePhoto,
                ),
                const SizedBox(height: 30),
                // Bottom buttons (Previous / Submit), aligned right
                BottomButtons(
                  onPrevious: () {
                    FocusScope.of(context).unfocus(); // Close keyboard before navigating back
                    Navigator.pop(context);
                  },
                  onSubmit: () {
                    _onSubmit(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
        ),
      ),
    );
  }

  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        widget.formData.photoPath = pickedFile.path;
        _photoMissing = false;
      });
    }
  }

  void _onSubmit(BuildContext context) {
    // Check if photo is present
    if (widget.formData.photoPath == null) {
      setState(() => _photoMissing = true);
      return;
    }

    // If everything is good, we do a mock submission
    // then go back to the shops screen
    Navigator.pop(context); // pop screen 2
    Navigator.pop(context); // pop screen 1
    // user ends up on RegisteredShopsScreen
  }
}
