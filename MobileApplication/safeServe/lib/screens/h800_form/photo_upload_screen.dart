// lib/screens/h800_form/photo_upload_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'score_screen.dart';
import 'h800_form_data.dart';

class H800PhotoUploadScreen extends StatefulWidget {
  final H800FormData formData;
  final String shopId, phiId;

  const H800PhotoUploadScreen(
      {super.key,
        required this.formData,
        required this.shopId,
        required this.phiId});

  @override
  State<H800PhotoUploadScreen> createState() => _H800PhotoUploadScreenState();
}

class _H800PhotoUploadScreenState extends State<H800PhotoUploadScreen> {
  final _picker = ImagePicker();
  final List<File> _photos = [];

  Future<void> _takePhoto() async {
    if (_photos.length == 10) return;
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => _photos.add(File(picked.path)));
    }
  }

  Future<void> _next() async {
    if (_photos.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Take at least 1 photo')));
      return;
    }
    final pos = await Geolocator.getCurrentPosition();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => H800ScoreScreen(
          formData: widget.formData,
          shopId: widget.shopId,
          phiId: widget.phiId,
          photos: _photos,
          position: pos,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inspection Photos')),
      body: Column(
        children: [
          Expanded(
            child: _photos.isEmpty
                ? Center(
                child: IconButton(
                    iconSize: 60,
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _takePhoto))
                : PageView(
              children: _photos
                  .map((f) => Image.file(f, fit: BoxFit.cover))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ElevatedButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera),
                    label: Text('${_photos.length}/10')),
                const Spacer(),
                ElevatedButton(
                    onPressed: _next,
                    child: const Text('Next', style: TextStyle(fontSize: 18)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
