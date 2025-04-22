// lib/screens/register_shop/screen_two/register_shop_screen_two.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../widgets/safe_serve_appbar.dart';
import 'widgets/photo_header.dart';
import 'widgets/photo_preview.dart';
import 'widgets/bottom_buttons.dart';
import '../register_shop_form_data.dart';

class RegisterShopScreenTwo extends StatefulWidget {
  final RegisterShopFormData formData;

  const RegisterShopScreenTwo({Key? key, required this.formData})
      : super(key: key);

  @override
  State<RegisterShopScreenTwo> createState() => _RegisterShopScreenTwoState();
}

class _RegisterShopScreenTwoState extends State<RegisterShopScreenTwo> {
  bool _photoMissing = false;

  final CollectionReference shopsRef =
  FirebaseFirestore.instance.collection('shops');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {},
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
                PhotoHeader(
                  title: 'Photo Upload',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                PhotoPreview(
                  photoPath: widget.formData.photoPath,
                  isMissing: _photoMissing,
                  onTap: _takePhoto,
                ),
                const SizedBox(height: 30),
                BottomButtons(
                  onPrevious: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                  onSubmit: () => _onSubmit(context),
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
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        widget.formData.photoPath = picked.path;
        _photoMissing = false;
      });
    }
  }

  Future<void> _onSubmit(BuildContext context) async {
    if (widget.formData.photoPath == null) {
      setState(() => _photoMissing = true);
      return;
    }

    try {
      final docId = widget.formData.establishmentName.trim();
      final filePath = 'shops_images/$docId.jpg';
      final file = File(widget.formData.photoPath!);

      // <-- Supply metadata here to avoid NPE in the native plugin
      final uploadTask = FirebaseStorage.instance
          .ref(filePath)
          .putFile(file, SettableMetadata(contentType: 'image/jpeg'));

      final snap = await uploadTask;
      final downloadURL = await snap.ref.getDownloadURL();

      await shopsRef.doc(docId).set({
        'referenceNo': widget.formData.referenceNo,
        'phiArea': widget.formData.phiArea,
        'typeOfTrade': widget.formData.typeOfTrade,
        'ownerName': widget.formData.ownerName,
        'address': widget.formData.privateAddress,
        'nicNumber': widget.formData.nicNumber,
        'telephone': widget.formData.telephoneNo,
        'name': widget.formData.establishmentName,
        'establishmentAddress': widget.formData.establishmentAddress,
        'licenseNumber': widget.formData.licenseNumber,
        'licensedDate': widget.formData.licensedDate,
        'businessRegNumber': widget.formData.businessRegNumber,
        'numberOfEmployees': widget.formData.numberOfEmployees,
        'image': downloadURL,
        'grade': 'N/A',
        'lastInspection': 'N/A',
      });

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error saving shop data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload: $e')),
      );
    }
  }
}
