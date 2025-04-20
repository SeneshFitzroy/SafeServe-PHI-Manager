import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'h800_form_summary.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenTen extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreenTen({super.key, required this.formData});

  @override
  H800FormScreenTenState createState() => H800FormScreenTenState();
}

class H800FormScreenTenState extends State<H800FormScreenTen> {
  // Part 10: Display of Health Instructions, Record Keeping & Certification
  String? _displayHealthInstructions;
  String? _entertainsComplaints;
  String? _preventSmoking;
  String? _issuingBills;
  String? _foodSafetyCertification;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _displayHealthInstructions = widget.formData.displayHealthInstructions;
    _entertainsComplaints = widget.formData.entertainsComplaints;
    _preventSmoking = widget.formData.preventSmoking;
    _issuingBills = widget.formData.issuingBills;
    _foodSafetyCertification = widget.formData.foodSafetyCertification;

    // Initialize validation flags
    _isInvalid = {
      'displayHealthInstructions': false,
      'entertainsComplaints': false,
      'preventSmoking': false,
      'issuingBills': false,
      'foodSafetyCertification': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['displayHealthInstructions'] = _displayHealthInstructions == null;
      _isInvalid['entertainsComplaints'] = _entertainsComplaints == null;
      _isInvalid['preventSmoking'] = _preventSmoking == null;
      _isInvalid['issuingBills'] = _issuingBills == null;
      _isInvalid['foodSafetyCertification'] = _foodSafetyCertification == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.displayHealthInstructions = _displayHealthInstructions;
    widget.formData.entertainsComplaints = _entertainsComplaints;
    widget.formData.preventSmoking = _preventSmoking;
    widget.formData.issuingBills = _issuingBills;
    widget.formData.foodSafetyCertification = _foodSafetyCertification;
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
                    value: 1.0, // 10/10 of the form completed
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Part 10: Display of Health Instructions, Record Keeping & Certification (5 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      RadioButtonField(
                        label: '10.1 Display of instructions and health messages for the consumers/employees',
                        value: _displayHealthInstructions,
                        isInvalid: _isInvalid['displayHealthInstructions']!,
                        onChanged: (value) {
                          setState(() {
                            _displayHealthInstructions = value;
                            _isInvalid['displayHealthInstructions'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '10.2 Entertains consumer/employee complaints and suggestions',
                        value: _entertainsComplaints,
                        isInvalid: _isInvalid['entertainsComplaints']!,
                        onChanged: (value) {
                          setState(() {
                            _entertainsComplaints = value;
                            _isInvalid['entertainsComplaints'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '10.3 Steps taken to prevent smoking within the premises',
                        value: _preventSmoking,
                        isInvalid: _isInvalid['preventSmoking']!,
                        onChanged: (value) {
                          setState(() {
                            _preventSmoking = value;
                            _isInvalid['preventSmoking'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '10.4 Issuing of bills & record keeping when selling/purchasing food',
                        value: _issuingBills,
                        isInvalid: _isInvalid['issuingBills']!,
                        onChanged: (value) {
                          setState(() {
                            _issuingBills = value;
                            _isInvalid['issuingBills'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '10.5 Availability of accredited certification on food safety',
                        value: _foodSafetyCertification,
                        isInvalid: _isInvalid['foodSafetyCertification']!,
                        onChanged: (value) {
                          setState(() {
                            _foodSafetyCertification = value;
                            _isInvalid['foodSafetyCertification'] = value == null;
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
                            label: 'Submit',
                            onPressed: () {
                              if (_validateForm()) {
                                _updateFormData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => H800FormSummary(
                                      formData: widget.formData,
                                    ),
                                  ),
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