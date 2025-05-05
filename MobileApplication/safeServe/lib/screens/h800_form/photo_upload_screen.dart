import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'score_screen.dart';
import 'h800_form_data.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';

class H800PhotoUploadScreen extends StatefulWidget {
  final H800FormData formData;
  final String shopId, phiId;

  const H800PhotoUploadScreen({
    super.key,
    required this.formData,
    required this.shopId,
    required this.phiId,
  });

  @override
  State<H800PhotoUploadScreen> createState() => _H800PhotoUploadScreenState();
}

class _H800PhotoUploadScreenState extends State<H800PhotoUploadScreen> {
  final _picker = ImagePicker();
  final List<File> _photos = [];

  Future<void> _takePhoto() async {
    if (_photos.length == 10) return;
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) setState(() => _photos.add(File(picked.path)));
  }

  Future<void> _next() async {
    if (_photos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Take at least 1 photo')),
      );
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
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () =>
            Scaffold.of(context).openEndDrawer(), // optional drawer
      ),
      endDrawer: const SafeServeDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back arrow + title
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 16, 25, 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDE6FE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF1F41BB)),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Photo Upload',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Photo container (25px horizontal padding, fixed height)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.61,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF4289FC)),
              ),
              clipBehavior: Clip.hardEdge,
              child: _photos.isEmpty
                  ? Center(
                child: IconButton(
                  iconSize: 60,
                  icon: const Icon(Icons.camera_alt,
                      color: Color(0xFF4289FC)),
                  onPressed: _takePhoto,
                ),
              )
                  : PageView(
                children: _photos
                    .map((f) => Image.file(f, fit: BoxFit.cover))
                    .toList(),
              ),
            ),
          ),

          const Spacer(),

          // Bottom buttons row
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 8, 25, 24),
            child: Row(
              children: [
                // Previous (camera count) button
                OutlinedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera, color: Color(0xFF1F41BB)),
                  label: Text(
                    '${_photos.length}/10',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F41BB),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1F41BB)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F41BB),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
