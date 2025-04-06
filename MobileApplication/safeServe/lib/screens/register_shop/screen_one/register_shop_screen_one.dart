// lib/screens/register_shop/screen_one/register_shop_screen_one.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../widgets/safe_serve_appbar.dart';
import 'widgets/register_shop_header.dart';
import 'widgets/form_text_field.dart';
import 'widgets/trade_dropdown.dart';
import 'widgets/licensed_year_field.dart';
import 'widgets/next_button.dart';
import '../register_shop_form_data.dart';

class RegisterShopScreenOne extends StatefulWidget {
  final RegisterShopFormData formData;

  const RegisterShopScreenOne({super.key, required this.formData});

  @override
  State<RegisterShopScreenOne> createState() => _RegisterShopScreenOneState();
}

class _RegisterShopScreenOneState extends State<RegisterShopScreenOne> {
  final ScrollController _scrollController = ScrollController();
  final Set<String> _invalidFields = {};

  // For focusing or date picking
  // We'll keep controllers in the sub-widgets this time

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Validate all required fields. If missing, store them in `_invalidFields`.
  /// Return `true` if all valid, else `false`.
  bool validateFields() {
    _invalidFields.clear();

    // Check each required field from widget.formData
    if (widget.formData.referenceNo.trim().isEmpty) {
      _invalidFields.add('referenceNo');
    }
    if (widget.formData.phiArea.trim().isEmpty) {
      _invalidFields.add('phiArea');
    }
    if (widget.formData.typeOfTrade.isEmpty) {
      _invalidFields.add('typeOfTrade');
    }
    if (widget.formData.ownerName.trim().isEmpty) {
      _invalidFields.add('ownerName');
    }
    if (widget.formData.privateAddress.trim().isEmpty) {
      _invalidFields.add('privateAddress');
    }
    if (widget.formData.nicNumber.trim().isEmpty) {
      _invalidFields.add('nicNumber');
    }
    if (widget.formData.telephoneNo.trim().isEmpty) {
      _invalidFields.add('telephoneNo');
    }
    if (widget.formData.establishmentName.trim().isEmpty) {
      _invalidFields.add('establishmentName');
    }
    if (widget.formData.establishmentAddress.trim().isEmpty) {
      _invalidFields.add('establishmentAddress');
    }
    if (widget.formData.licenseNumber.trim().isEmpty) {
      _invalidFields.add('licenseNumber');
    }
    if (widget.formData.licensedDate.trim().isEmpty) {
      _invalidFields.add('licensedDate');
    }
    if (widget.formData.businessRegNumber.trim().isEmpty) {
      _invalidFields.add('businessRegNumber');
    }
    if (widget.formData.numberOfEmployees.trim().isEmpty) {
      _invalidFields.add('numberOfEmployees');
    }

    setState(() {}); // to refresh UI
    return _invalidFields.isEmpty;
  }

  /// Check if a particular field is invalid
  bool isFieldInvalid(String fieldKey) => _invalidFields.contains(fieldKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {
          // optional if you want to open a drawer
        },
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header row
                RegisterShopHeader(
                  title: 'Register New Shop',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),

                // 1. Reference No
                FormTextField(
                  label: 'Reference No',
                  isInvalid: isFieldInvalid('referenceNo'),
                  initialValue: widget.formData.referenceNo,
                  onChanged: (val) => widget.formData.referenceNo = val,
                ),
                // 2. PHI Area
                FormTextField(
                  label: 'PHI Area',
                  isInvalid: isFieldInvalid('phiArea'),
                  initialValue: widget.formData.phiArea,
                  onChanged: (val) => widget.formData.phiArea = val,
                ),
                // 3. Type of Trade (Dropdown)
                TradeDropdown(
                  label: 'Type of Trade',
                  isInvalid: isFieldInvalid('typeOfTrade'),
                  initialValue: widget.formData.typeOfTrade,
                  onChanged: (val) => widget.formData.typeOfTrade = val,
                ),
                // 4. Owner Name
                FormTextField(
                  label: 'Name of the Owner',
                  isInvalid: isFieldInvalid('ownerName'),
                  initialValue: widget.formData.ownerName,
                  onChanged: (val) => widget.formData.ownerName = val,
                ),
                // 5. Private Address
                FormTextField(
                  label: 'Private Address',
                  isInvalid: isFieldInvalid('privateAddress'),
                  initialValue: widget.formData.privateAddress,
                  onChanged: (val) => widget.formData.privateAddress = val,
                ),
                // 6. NIC Number
                FormTextField(
                  label: 'NIC Number',
                  isInvalid: isFieldInvalid('nicNumber'),
                  initialValue: widget.formData.nicNumber,
                  onChanged: (val) => widget.formData.nicNumber = val,
                ),
                // 7. Telephone No
                FormTextField(
                  label: 'Telephone NO',
                  isInvalid: isFieldInvalid('telephoneNo'),
                  initialValue: widget.formData.telephoneNo,
                  inputType: TextInputType.phone,
                  onChanged: (val) => widget.formData.telephoneNo = val,
                ),
                // 8. Establishment Name
                FormTextField(
                  label: 'Name of the Establishment',
                  isInvalid: isFieldInvalid('establishmentName'),
                  initialValue: widget.formData.establishmentName,
                  onChanged: (val) => widget.formData.establishmentName = val,
                ),
                // 9. Establishment Address
                FormTextField(
                  label: 'Address of the Establishment',
                  isInvalid: isFieldInvalid('establishmentAddress'),
                  initialValue: widget.formData.establishmentAddress,
                  onChanged: (val) =>
                      widget.formData.establishmentAddress = val,
                ),
                // 10. License Number
                FormTextField(
                  label: 'License Number',
                  isInvalid: isFieldInvalid('licenseNumber'),
                  initialValue: widget.formData.licenseNumber,
                  inputType: TextInputType.number,
                  onChanged: (val) => widget.formData.licenseNumber = val,
                ),
                // 11. Licensed Date (Picker)
                LicensedYearField(
                  label: 'Licensed Date',
                  isInvalid: isFieldInvalid('licensedDate'),
                  initialValue: widget.formData.licensedDate,
                  onDatePicked: (val) => widget.formData.licensedDate = val,
                ),
                // 12. Business Reg Number
                FormTextField(
                  label: 'Business Registration Number',
                  isInvalid: isFieldInvalid('businessRegNumber'),
                  initialValue: widget.formData.businessRegNumber,
                  onChanged: (val) => widget.formData.businessRegNumber = val,
                ),
                // 13. Number of Employees
                FormTextField(
                  label: 'Number of Employees',
                  isInvalid: isFieldInvalid('numberOfEmployees'),
                  initialValue: widget.formData.numberOfEmployees,
                  inputType: TextInputType.number,
                  onChanged: (val) => widget.formData.numberOfEmployees = val,
                ),
                const SizedBox(height: 30),

                // Next Button on the right
                NextButton(
                  onPressed: () {
                    if (validateFields()) {
                      // Ensure all fields are filled
                      Navigator.pushNamed(
                        context,
                        '/register_shop_screen_two',
                        arguments: widget.formData, // Pass filled form data
                      );
                    }
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
}
