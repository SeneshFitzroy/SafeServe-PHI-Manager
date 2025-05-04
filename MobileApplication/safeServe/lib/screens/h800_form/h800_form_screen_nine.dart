import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenNine extends StatefulWidget {
  final H800FormData formData;
  final String shopId;
  final String phiId;

  const H800FormScreenNine({
    super.key,
    required this.formData,
    required this.shopId,
    required this.phiId,
  });

  @override
  H800FormScreenNineState createState() => H800FormScreenNineState();
}

class H800FormScreenNineState extends State<H800FormScreenNine> {
  // Part 9: Health Status and Training of Food Handlers
  String? _personalHygiene;
  String? _wearingProtectiveClothing;
  String? _communicableDiseases;
  String? _goodHealthHabits;
  String? _healthRecords;
  String? _trainingRecords;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _personalHygiene = widget.formData.personalHygiene;
    _wearingProtectiveClothing = widget.formData.wearingProtectiveClothing;
    _communicableDiseases = widget.formData.communicableDiseases;
    _goodHealthHabits = widget.formData.goodHealthHabits;
    _healthRecords = widget.formData.healthRecords;
    _trainingRecords = widget.formData.trainingRecords;

    // Initialize validation flags
    _isInvalid = {
      'personalHygiene': false,
      'wearingProtectiveClothing': false,
      'communicableDiseases': false,
      'goodHealthHabits': false,
      'healthRecords': false,
      'trainingRecords': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['personalHygiene'] = _personalHygiene == null;
      _isInvalid['wearingProtectiveClothing'] =
          _wearingProtectiveClothing == null;
      _isInvalid['communicableDiseases'] = _communicableDiseases == null;
      _isInvalid['goodHealthHabits'] = _goodHealthHabits == null;
      _isInvalid['healthRecords'] = _healthRecords == null;
      _isInvalid['trainingRecords'] = _trainingRecords == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.personalHygiene = _personalHygiene;
    widget.formData.wearingProtectiveClothing = _wearingProtectiveClothing;
    widget.formData.communicableDiseases = _communicableDiseases;
    widget.formData.goodHealthHabits = _goodHealthHabits;
    widget.formData.healthRecords = _healthRecords;
    widget.formData.trainingRecords = _trainingRecords;
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
                    value: 0.9, // 9/10 of the form completed
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
                        'Part 9: Health Status and Training of Food Handlers (10 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '9.1 Personal hygiene',
                        initialValue: _personalHygiene,
                        isInvalid: _isInvalid['personalHygiene']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _personalHygiene = value;
                            _isInvalid['personalHygiene'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '9.2 Wearing of protective clothing',
                        initialValue: _wearingProtectiveClothing,
                        isInvalid: _isInvalid['wearingProtectiveClothing']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _wearingProtectiveClothing = value;
                            _isInvalid['wearingProtectiveClothing'] =
                                value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '9.3 Communicable diseases/skin diseases',
                        value: _communicableDiseases,
                        isInvalid: _isInvalid['communicableDiseases']!,
                        onChanged: (value) {
                          setState(() {
                            _communicableDiseases = value;
                            _isInvalid['communicableDiseases'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '9.4 Good health habits',
                        initialValue: _goodHealthHabits,
                        isInvalid: _isInvalid['goodHealthHabits']!,
                        items: const ['Practiced', 'Not Practiced'],
                        onChanged: (value) {
                          setState(() {
                            _goodHealthHabits = value;
                            _isInvalid['goodHealthHabits'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '9.5 Maintenance of health records of employees',
                        initialValue: _healthRecords,
                        isInvalid: _isInvalid['healthRecords']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _healthRecords = value;
                            _isInvalid['healthRecords'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label:
                        '9.6 Maintenance of records regarding training on health employees',
                        initialValue: _trainingRecords,
                        isInvalid: _isInvalid['trainingRecords']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _trainingRecords = value;
                            _isInvalid['trainingRecords'] = value == null;
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
                                  '/h800_form_screen_ten',
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
