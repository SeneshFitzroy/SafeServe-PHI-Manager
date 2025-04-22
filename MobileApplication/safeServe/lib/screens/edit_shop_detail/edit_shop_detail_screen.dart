// lib/screens/edit_shop_detail/edit_shop_detail_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/form_text_field.dart';
import '../register_shop/screen_one/widgets/trade_dropdown.dart';

class EditShopDetailScreen extends StatefulWidget {
  const EditShopDetailScreen({Key? key}) : super(key: key);

  @override
  State<EditShopDetailScreen> createState() => _EditShopDetailScreenState();
}

class _EditShopDetailScreenState extends State<EditShopDetailScreen> {
  late Map<String, dynamic> shopData;

  final _refNoCtrl  = TextEditingController();
  final _phiAreaCtrl= TextEditingController();
  final _ownerCtrl  = TextEditingController();
  final _addressCtrl= TextEditingController();
  final _nicCtrl    = TextEditingController();
  final _telCtrl    = TextEditingController();
  final _nameCtrl   = TextEditingController();
  final _licNumCtrl = TextEditingController();
  final _licDateCtrl= TextEditingController();
  final _busRegCtrl = TextEditingController();
  final _numEmpCtrl = TextEditingController();

  String _typeOfTrade = '';
  String? _capturedImagePath;

  final shopsRef = FirebaseFirestore.instance.collection('shops');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    shopData = (args is Map<String, dynamic>) ? args : {};
    _populateFields(shopData);
  }

  void _populateFields(Map<String, dynamic> data) {
    _refNoCtrl.text   = data['referenceNo'] ?? '';
    _phiAreaCtrl.text = data['phiArea'] ?? '';
    _typeOfTrade      = data['typeOfTrade'] ?? '';
    _ownerCtrl.text   = data['ownerName'] ?? '';
    _addressCtrl.text = data['address'] ?? '';
    _nicCtrl.text     = data['nicNumber'] ?? '';
    _telCtrl.text     = data['telephone'] ?? '';
    _nameCtrl.text    = data['name'] ?? '';
    _licNumCtrl.text  = data['licenseNumber'] ?? '';
    _licDateCtrl.text = data['licensedDate'] ?? '';
    _busRegCtrl.text  = data['businessRegNumber'] ?? '';
    _numEmpCtrl.text  = data['numberOfEmployees'] ?? '';
  }

  @override
  void dispose() {
    _refNoCtrl.dispose();
    _phiAreaCtrl.dispose();
    _ownerCtrl.dispose();
    _addressCtrl.dispose();
    _nicCtrl.dispose();
    _telCtrl.dispose();
    _nameCtrl.dispose();
    _licNumCtrl.dispose();
    _licDateCtrl.dispose();
    _busRegCtrl.dispose();
    _numEmpCtrl.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => _capturedImagePath = picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentImage = shopData['image'] as String? ?? '';
    final displayPath  = _capturedImagePath ?? currentImage;

    return Scaffold(
      appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
      body: Container(
        decoration: _buildGradient(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              FormTextField(
                label: 'Reference No',
                isInvalid: false,
                initialValue: _refNoCtrl.text,
                onChanged: (v) => _refNoCtrl.text = v,
              ),
              FormTextField(
                label: 'PHI Area',
                isInvalid: false,
                initialValue: _phiAreaCtrl.text,
                onChanged: (v) => _phiAreaCtrl.text = v,
              ),
              TradeDropdown(
                label: 'Type of Trade',
                isInvalid: false,
                initialValue: _typeOfTrade,
                onChanged: (v) => _typeOfTrade = v,
              ),
              // … other text fields …
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Text('Image of the Shop',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: _captureImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF4289FC)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: displayPath.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: displayPath.startsWith('http')
                          ? Image.network(displayPath, fit: BoxFit.cover)
                          : displayPath.startsWith('assets/')
                          ? Image.asset(displayPath, fit: BoxFit.cover)
                          : Image.file(File(displayPath), fit: BoxFit.cover),
                    )
                        : const Center(child: Text('Tap to capture an image')),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1F41BB),
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF1F41BB)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, '/shop_detail',
                          arguments: shopData['name'] ?? ''),
                      child: const Text('Cancel',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F41BB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                      ),
                      onPressed: _handleSave,
                      child: const Text('Save',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFCDE6FE),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.arrow_back_rounded,
                color: Color(0xFF1F41BB)),
          ),
        ),
        const SizedBox(width: 12),
        const Text('Edit Shop Details',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ],
    ),
  );

  BoxDecoration _buildGradient() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
    ),
  );

  Future<void> _handleSave() async {
    final docId = shopData['name'] ?? '';
    if (docId.isEmpty) {
      Navigator.pushReplacementNamed(context, '/shop_detail', arguments: docId);
      return;
    }

    try {
      String? downloadURL;
      if (_capturedImagePath != null) {
        final filePath = 'shops_images/$docId.jpg';
        final file = File(_capturedImagePath!);
        final uploadTask = FirebaseStorage.instance
            .ref(filePath)
            .putFile(file, SettableMetadata(contentType: 'image/jpeg'));
        final snap = await uploadTask;
        downloadURL = await snap.ref.getDownloadURL();
      }

      final data = {
        'referenceNo': _refNoCtrl.text.trim(),
        'phiArea': _phiAreaCtrl.text.trim(),
        'typeOfTrade': _typeOfTrade,
        'ownerName': _ownerCtrl.text.trim(),
        'address': _addressCtrl.text.trim(),
        'nicNumber': _nicCtrl.text.trim(),
        'telephone': _telCtrl.text.trim(),
        'name': _nameCtrl.text.trim(),
        'licenseNumber': _licNumCtrl.text.trim(),
        'licensedDate': _licDateCtrl.text.trim(),
        'businessRegNumber': _busRegCtrl.text.trim(),
        'numberOfEmployees': _numEmpCtrl.text.trim(),
      };
      if (downloadURL != null) data['image'] = downloadURL;

      await shopsRef.doc(docId).update(data);

      Navigator.pushReplacementNamed(context, '/shop_detail', arguments: docId);
    } catch (e) {
      debugPrint('Error updating shop: $e');
      Navigator.pushReplacementNamed(context, '/shop_detail', arguments: docId);
    }
  }
}
