import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/form_text_field.dart';
import '../register_shop/screen_one/widgets/trade_dropdown.dart';

class EditShopDetailScreen extends StatefulWidget {
  const EditShopDetailScreen({super.key});

  @override
  State<EditShopDetailScreen> createState() => _EditShopDetailScreenState();
}

class _EditShopDetailScreenState extends State<EditShopDetailScreen> {
  // We'll store the original shop data
  late Map<String, dynamic> shopData;

  // Text controllers for each editable field
  final TextEditingController _referenceNoController = TextEditingController();
  final TextEditingController _phiAreaController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _privateAddressController = TextEditingController();
  final TextEditingController _nicNumberController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _nameOfEstablishmentController = TextEditingController();
  final TextEditingController _addressOfEstablishmentController = TextEditingController();
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _licensedDateController = TextEditingController();
  final TextEditingController _businessRegNumberController = TextEditingController();
  final TextEditingController _numberOfEmployeesController = TextEditingController();

  String _typeOfTrade = '';

  String? _capturedImagePath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      shopData = args;
    } else {
      shopData = {};
    }
    _populateFields(shopData);
  }

  void _populateFields(Map<String, dynamic> data) {
    _referenceNoController.text = data['referenceNo'] ?? '';
    _phiAreaController.text = data['phiArea'] ?? '';
    _typeOfTrade = data['typeOfTrade'] ?? '';
    _ownerNameController.text = data['ownerName'] ?? '';
    // We'll consider "private address" as data['address']
    _privateAddressController.text = data['address'] ?? '';
    _nicNumberController.text = data['nicNumber'] ?? '';
    _telephoneController.text = data['telephone'] ?? '';
    _nameOfEstablishmentController.text = data['name'] ?? '';
    _addressOfEstablishmentController.text = data['address'] ?? '';
    _licenseNumberController.text = data['licenseNumber'] ?? '';
    _licensedDateController.text = data['licensedDate'] ?? '';
    _businessRegNumberController.text = data['businessRegNumber'] ?? '';
    _numberOfEmployeesController.text = data['numberOfEmployees'] ?? '';
  }

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _capturedImagePath = pickedFile.path; // Real file path from camera
      });
    }
  }

  @override
  void dispose() {
    _referenceNoController.dispose();
    _phiAreaController.dispose();
    _ownerNameController.dispose();
    _privateAddressController.dispose();
    _nicNumberController.dispose();
    _telephoneController.dispose();
    _nameOfEstablishmentController.dispose();
    _addressOfEstablishmentController.dispose();
    _licenseNumberController.dispose();
    _licensedDateController.dispose();
    _businessRegNumberController.dispose();
    _numberOfEmployeesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {
        },
      ),
      body: Container(
        decoration: _buildGradientBackgroundDecoration(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              // Editable form fields:
              FormTextField(
                label: 'Reference No',
                isInvalid: false,
                initialValue: _referenceNoController.text,
                onChanged: (val) => _referenceNoController.text = val,
              ),
              FormTextField(
                label: 'PHI Area',
                isInvalid: false,
                initialValue: _phiAreaController.text,
                onChanged: (val) => _phiAreaController.text = val,
              ),
              TradeDropdown(
                label: 'Type of Trade',
                isInvalid: false,
                initialValue: _typeOfTrade,
                onChanged: (val) => _typeOfTrade = val,
              ),
              FormTextField(
                label: 'Name of the Owner',
                isInvalid: false,
                initialValue: _ownerNameController.text,
                onChanged: (val) => _ownerNameController.text = val,
              ),
              FormTextField(
                label: 'Private Address',
                isInvalid: false,
                initialValue: _privateAddressController.text,
                onChanged: (val) => _privateAddressController.text = val,
              ),
              FormTextField(
                label: 'NIC Number',
                isInvalid: false,
                initialValue: _nicNumberController.text,
                onChanged: (val) => _nicNumberController.text = val,
              ),
              FormTextField(
                label: 'Telephone NO',
                isInvalid: false,
                initialValue: _telephoneController.text,
                inputType: TextInputType.phone,
                onChanged: (val) => _telephoneController.text = val,
              ),
              FormTextField(
                label: 'Name of the Establishment',
                isInvalid: false,
                initialValue: _nameOfEstablishmentController.text,
                onChanged: (val) => _nameOfEstablishmentController.text = val,
              ),
              FormTextField(
                label: 'Address of the Establishment',
                isInvalid: false,
                initialValue: _addressOfEstablishmentController.text,
                onChanged: (val) => _addressOfEstablishmentController.text = val,
              ),
              FormTextField(
                label: 'License Number',
                isInvalid: false,
                initialValue: _licenseNumberController.text,
                inputType: TextInputType.number,
                onChanged: (val) => _licenseNumberController.text = val,
              ),
              FormTextField(
                label: 'Licensed Date',
                isInvalid: false,
                initialValue: _licensedDateController.text,
                onChanged: (val) => _licensedDateController.text = val,
              ),
              FormTextField(
                label: 'Business Registration Number',
                isInvalid: false,
                initialValue: _businessRegNumberController.text,
                onChanged: (val) => _businessRegNumberController.text = val,
              ),
              FormTextField(
                label: 'Number of Employees',
                isInvalid: false,
                initialValue: _numberOfEmployeesController.text,
                inputType: TextInputType.number,
                onChanged: (val) => _numberOfEmployeesController.text = val,
              ),
              const SizedBox(height: 15),
              // Image capture field:
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Text(
                  'Image of the Shop',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              _buildImageCaptureArea(),
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/shop_detail',
                          arguments: shopData['name'] ?? '',
                        );
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F41BB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                      ),
                      onPressed: _handleSave,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
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
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF1F41BB),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Edit Shop Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildGradientBackgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFE6F5FE),
          Color(0xFFF5ECF9),
        ],
      ),
    );
  }

  Widget _buildImageCaptureArea() {
    final oldImagePath = shopData['image'] ?? '';
    final displayPath = _capturedImagePath ?? oldImagePath;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: _captureImage,
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFF4289FC),
            ),
          ),
          child: displayPath.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: displayPath.startsWith('assets/')
                ? Image.asset(
              displayPath,
              fit: BoxFit.cover,
              width: double.infinity,
            )
                : Image.file(
              File(displayPath),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          )
              : const Center(child: Text('Tap to capture an image')),
        ),
      ),
    );
  }

  void _handleSave() {
    final newName = _nameOfEstablishmentController.text.trim();
    final fallbackName = shopData['name'] ?? '';

    Navigator.pushReplacementNamed(
      context,
      '/shop_detail',
      arguments: newName.isNotEmpty ? newName : fallbackName,
    );
  }
}