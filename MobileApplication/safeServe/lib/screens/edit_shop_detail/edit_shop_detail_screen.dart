import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/form_text_field.dart';
import '../register_shop/screen_one/widgets/licensed_year_field.dart';
import '../register_shop/screen_one/widgets/searchable_trade_dropdown.dart';

class EditShopDetailScreen extends StatefulWidget {
  const EditShopDetailScreen({Key? key}) : super(key: key);

  @override
  State<EditShopDetailScreen> createState() => _EditShopDetailScreenState();
}

class _EditShopDetailScreenState extends State<EditShopDetailScreen> {
  late Map<String, dynamic> shopData;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _referenceCtrl        = TextEditingController();
  final _businessRegCtrl      = TextEditingController();
  final _establishmentNameCtrl= TextEditingController();
  final _establishmentAddrCtrl= TextEditingController();
  final _licenseNumCtrl       = TextEditingController();
  final _licensedDateCtrl     = TextEditingController();
  final _numEmployeesCtrl     = TextEditingController();
  final _ownerNameCtrl        = TextEditingController();
  final _nicCtrl              = TextEditingController();
  final _privateAddrCtrl      = TextEditingController();
  final _telephoneCtrl        = TextEditingController();

  String _district = '';
  List<String> _gnDivisions = [];
  String _gnDivision = '';
  String _typeOfTrade = '';

  String? _capturedImagePath;
  double? _lat;
  double? _lng;

  final _shopsRef = FirebaseFirestore.instance.collection('shops');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      shopData = args;
    } else {
      shopData = {};
    }
    _loadInitial();
  }

  Future<void> _loadInitial() async {
    // Text fields
    _referenceCtrl.text        = shopData['referenceNo'] ?? '';
    _businessRegCtrl.text      = shopData['businessRegNumber'] ?? '';
    _establishmentNameCtrl.text= shopData['name'] ?? '';
    _establishmentAddrCtrl.text= shopData['establishmentAddress'] ?? '';
    _licenseNumCtrl.text       = shopData['licenseNumber'] ?? '';
    final licDate = shopData['licensedDate'];
    if (licDate is Timestamp) {
      _licensedDateCtrl.text = DateFormat('yyyy-MM-dd').format(licDate.toDate());
    } else {
      _licensedDateCtrl.text = licDate?.toString() ?? '';
    }
    _numEmployeesCtrl.text     = (shopData['numberOfEmployees'] ?? '').toString();
    _ownerNameCtrl.text        = shopData['ownerName'] ?? '';
    _nicCtrl.text              = shopData['nicNumber'] ?? '';
    _privateAddrCtrl.text      = shopData['privateAddress'] ?? '';
    _telephoneCtrl.text        = shopData['telephone'] ?? '';

    // District & GN from shopData
    _district = shopData['district'] ?? '';
    final gnList = (shopData['gnDivisions'] as List?)?.cast<String>() ?? [];
    setState(() {
      _gnDivisions = gnList;
      _gnDivision = shopData['gnDivision'] ?? (gnList.isNotEmpty ? gnList.first : '');
    });

    // Trade
    _typeOfTrade = shopData['typeOfTrade'] ?? '';

    // Image & location
    final loc = shopData['location'];
    if (loc is GeoPoint) {
      _lat = loc.latitude;
      _lng = loc.longitude;
    }
  }

  @override
  void dispose() {
    _referenceCtrl.dispose();
    _businessRegCtrl.dispose();
    _establishmentNameCtrl.dispose();
    _establishmentAddrCtrl.dispose();
    _licenseNumCtrl.dispose();
    _licensedDateCtrl.dispose();
    _numEmployeesCtrl.dispose();
    _ownerNameCtrl.dispose();
    _nicCtrl.dispose();
    _privateAddrCtrl.dispose();
    _telephoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      final pos = await Geolocator.getCurrentPosition();
      setState(() {
        _capturedImagePath = picked.path;
        _lat = pos.latitude;
        _lng = pos.longitude;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentImage = shopData['image'] as String? ?? '';
    final displayPath  = _capturedImagePath ?? currentImage;

    return Scaffold(
      appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildHeader(),
              const SizedBox(height: 20),

              // 1 Reference No
              FormTextField(
                label: 'Reference Number',
                isInvalid: false,
                initialValue: _referenceCtrl.text,
                inputType: TextInputType.number,
                maxLength: 6,
                onChanged: (v) => _referenceCtrl.text = v,
              ),

              // 2 Business Reg
              FormTextField(
                label: 'Business Registration Number',
                isInvalid: false,
                initialValue: _businessRegCtrl.text,
                inputType: TextInputType.number,
                maxLength: 6,
                onChanged: (v) => _businessRegCtrl.text = v,
              ),

              // 3 Establishment Name
              FormTextField(
                label: 'Name of the Establishment',
                isInvalid: false,
                initialValue: _establishmentNameCtrl.text,
                onChanged: (v) => _establishmentNameCtrl.text = v,
              ),

              // 4 Establishment Address
              FormTextField(
                label: 'Address of the Establishment',
                isInvalid: false,
                initialValue: _establishmentAddrCtrl.text,
                onChanged: (v) => _establishmentAddrCtrl.text = v,
              ),

              // 5 District (read-only)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('District', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(_district, style: const TextStyle(fontSize: 16)),
                  ),
                ]),
              ),

              // 6 GN Division
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('GN Division', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF4289FC)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _gnDivision,
                        isExpanded: true,
                        items: _gnDivisions
                            .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                            .toList(),
                        onChanged: (v) => setState(() => _gnDivision = v!),
                      ),
                    ),
                  ),
                ]),
              ),

              // 7 License Number
              FormTextField(
                label: 'License Number',
                isInvalid: false,
                initialValue: _licenseNumCtrl.text,
                inputType: TextInputType.number,
                maxLength: 6,
                onChanged: (v) => _licenseNumCtrl.text = v,
              ),

              // 8 Licensed Date
              LicensedYearField(
                label: 'Licensed Date',
                isInvalid: false,
                initialValue: _licensedDateCtrl.text,
                onDatePicked: (v) => _licensedDateCtrl.text = v,
              ),

              // 9 Type of Trade
              SearchableTradeDropdown(
                initial: _typeOfTrade,
                onSelected: (v) => setState(() {
                  _typeOfTrade = v;
                }),
              ),

              // 10 Number of Employees
              FormTextField(
                label: 'Number of Employees',
                isInvalid: false,
                initialValue: _numEmployeesCtrl.text,
                inputType: TextInputType.number,
                onChanged: (v) => _numEmployeesCtrl.text = v,
              ),

              // 11 Name of Owner
              FormTextField(
                label: 'Name of the Owner',
                isInvalid: false,
                initialValue: _ownerNameCtrl.text,
                onChanged: (v) => _ownerNameCtrl.text = v,
              ),

              // 12 NIC Number
              FormTextField(
                label: 'NIC Number',
                isInvalid: false,
                initialValue: _nicCtrl.text,
                onChanged: (v) => _nicCtrl.text = v,
              ),

              // 13 Private Address
              FormTextField(
                label: 'Private Address',
                isInvalid: false,
                initialValue: _privateAddrCtrl.text,
                onChanged: (v) => _privateAddrCtrl.text = v,
              ),

              // 14 Telephone Number
              FormTextField(
                label: 'Telephone Number',
                isInvalid: false,
                initialValue: _telephoneCtrl.text,
                inputType: TextInputType.phone,
                maxLength: 10,
                onChanged: (v) => _telephoneCtrl.text = v,
              ),

              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Text('Image of the Shop', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: _captureImage,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF4289FC)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: displayImage(displayPath),
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
                        side: const BorderSide(color: Color(0xFF1F41BB)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                      ),
                      onPressed: () => Navigator.pop(context),
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
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }

  Widget displayImage(String path) {
    if (path.isEmpty) return const Center(child: Text('Tap to capture'));
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover);
    }
    if (path.startsWith('assets/')) {
      return Image.asset(path, fit: BoxFit.cover);
    }
    return Image.file(File(path), fit: BoxFit.cover);
  }

  Widget _buildHeader() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(children: [
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
    ]),
  );

  Future<void> _handleSave() async {
    final docId = _referenceCtrl.text.trim();
    if (docId.isEmpty) {
      Navigator.pop(context);
      return;
    }

    String? imageUrl;
    if (_capturedImagePath != null) {
      final snap = await FirebaseStorage.instance
          .ref('shops_images/$docId.jpg')
          .putFile(File(_capturedImagePath!),
          SettableMetadata(contentType: 'image/jpeg'));
      imageUrl = await snap.ref.getDownloadURL();
    }

    final data = {
      'referenceNo': _referenceCtrl.text.trim(),
      'businessRegNumber': _businessRegCtrl.text.trim(),
      'name': _establishmentNameCtrl.text.trim(),
      'establishmentAddress': _establishmentAddrCtrl.text.trim(),
      'district': _district,
      'gnDivision': _gnDivision,
      'licenseNumber': _licenseNumCtrl.text.trim(),
      'licensedDate': Timestamp.fromDate(
        DateFormat('yyyy-MM-dd').parse(_licensedDateCtrl.text.trim()),
      ),
      'typeOfTrade': _typeOfTrade,
      'numberOfEmployees': int.tryParse(_numEmployeesCtrl.text) ?? 0,
      'ownerName': _ownerNameCtrl.text.trim(),
      'nicNumber': _nicCtrl.text.trim(),
      'privateAddress': _privateAddrCtrl.text.trim(),
      'telephone': _telephoneCtrl.text.trim(),
    };
    if (imageUrl != null) data['image'] = imageUrl;
    if (_lat != null && _lng != null) {
      data['location'] = GeoPoint(_lat!, _lng!);
    }

    await _shopsRef.doc(docId).update(data);
    Navigator.pushReplacementNamed(context, '/shop_detail', arguments: docId);
  }
}
