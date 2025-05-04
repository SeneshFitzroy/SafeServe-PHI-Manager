import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../h800_form/widgets/h800_form_button.dart';
import '../h800_form/h800_form_data.dart';
import 'score_screen.dart';

class PhotoUploadScreen extends StatefulWidget {
  final H800FormData form;
  final String shopId;
  final String phiId;
  const PhotoUploadScreen({super.key, required this.form, required this.shopId, required this.phiId});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final _picker = ImagePicker();
  final _files  = <File>[];
  GeoPoint? _firstLocation;
  final _page = PageController();

  Future<void> _takePhoto() async {
    if (_files.length == 10) return;
    final x = await _picker.pickImage(source: ImageSource.camera);
    if (x == null) return;

    if (_files.isEmpty) {
      final pos = await Geolocator.getCurrentPosition();
      _firstLocation = GeoPoint(pos.latitude, pos.longitude);
    }
    setState(() => _files.add(File(x.path)));
    await Future.delayed(const Duration(milliseconds: 150));
    _page.jumpToPage(_files.length - 1);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
    body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 25),
            Expanded(
              child: _files.isEmpty
                  ? Center(
                child: InkWell(
                  onTap: _takePhoto,
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 60),
                  ),
                ),
              )
                  : PageView.builder(
                controller: _page,
                itemCount: _files.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_files[i], fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            H800FormButton(label: _files.isEmpty ? 'Take Photo' : 'Add Another', onPressed: _takePhoto),
            if (_files.isNotEmpty) ...[
              const SizedBox(height: 12),
              H800FormButton(
                label: 'Continue',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScoreScreen(
                      form   : widget.form,
                      shopId : widget.shopId,
                      phiId  : widget.phiId,
                      photos : _files,
                      firstLocation: _firstLocation,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 35),
          ],
        ),
      ],
    ),
  );
}
