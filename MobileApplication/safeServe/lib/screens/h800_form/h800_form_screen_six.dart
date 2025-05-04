import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenSix extends StatefulWidget {
  final H800FormData formData;
  final String shopId;
  final String phiId;

  const H800FormScreenSix({
    super.key,
    required this.formData,
    required this.shopId,
    required this.phiId,
  });

  @override
  H800FormScreenSixState createState() => H800FormScreenSixState();
}

class H800FormScreenSixState extends State<H800FormScreenSix> {
  // Part 6: Water Supply
  String? _waterSource;
  String? _waterStorageMethod;
  String? _waterDispensedThroughTaps;
  String? _waterSafetyCertified;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _waterSource = widget.formData.waterSource;
    _waterStorageMethod = widget.formData.waterStorageMethod;
    _waterDispensedThroughTaps = widget.formData.waterDispensedThroughTaps;
    _waterSafetyCertified = widget.formData.waterSafetyCertified;

    // Initialize validation flags
    _isInvalid = {
      'waterSource': false,
      'waterStorageMethod': false,
      'waterDispensedThroughTaps': false,
      'waterSafetyCertified': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['waterSource'] = _waterSource == null;
      _isInvalid['waterStorageMethod'] = _waterStorageMethod == null;
      _isInvalid['waterDispensedThroughTaps'] =
          _waterDispensedThroughTaps == null;
      _isInvalid['waterSafetyCertified'] = _waterSafetyCertified == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.waterSource = _waterSource;
    widget.formData.waterStorageMethod = _waterStorageMethod;
    widget.formData.waterDispensedThroughTaps = _waterDispensedThroughTaps;
    widget.formData.waterSafetyCertified = _waterSafetyCertified;
  }

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
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                RegisterShopHeader(
                  title: 'H800 Form',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: 0.6, // 6/10 of the form completed
                    backgroundColor: Colors.grey[300],
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Part 6: Water Supply (5 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '6.1 Water source',
                        initialValue: _waterSource,
                        isInvalid: _isInvalid['waterSource']!,
                        items: const ['Safe', 'Unsafe'],
                        onChanged: (value) {
                          setState(() {
                            _waterSource = value;
                            _isInvalid['waterSource'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '6.2 Water storage method',
                        initialValue: _waterStorageMethod,
                        isInvalid: _isInvalid['waterStorageMethod']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _waterStorageMethod = value;
                            _isInvalid['waterStorageMethod'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '6.3 Water dispensed through taps',
                        value: _waterDispensedThroughTaps,
                        isInvalid: _isInvalid['waterDispensedThroughTaps']!,
                        onChanged: (value) {
                          setState(() {
                            _waterDispensedThroughTaps = value;
                            _isInvalid['waterDispensedThroughTaps'] =
                                value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label:
                        '6.4 Safety of water certified by analytical reports (Bacteriology - 01, Chemical - 01)',
                        value: _waterSafetyCertified,
                        isInvalid: _isInvalid['waterSafetyCertified']!,
                        onChanged: (value) {
                          setState(() {
                            _waterSafetyCertified = value;
                            _isInvalid['waterSafetyCertified'] = value == null;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          H800FormButton(
                            label: 'Previous',
                            onPressed: () {
                              _updateFormData();
                              Navigator.pop(context);
                            },
                          ),
                          H800FormButton(
                            label: 'Next',
                            onPressed: () {
                              if (_validateForm()) {
                                _updateFormData();
                                Navigator.pushNamed(
                                  context,
                                  '/h800_form_screen_seven',
                                  arguments: {
                                    'formData': widget.formData,
                                    'shopId': widget.shopId,
                                    'phiId': widget.phiId,
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
