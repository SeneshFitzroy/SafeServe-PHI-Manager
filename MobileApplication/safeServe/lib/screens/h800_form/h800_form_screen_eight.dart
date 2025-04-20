import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenEight extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreenEight({super.key, required this.formData});

  @override
  H800FormScreenEightState createState() => H800FormScreenEightState();
}

class H800FormScreenEightState extends State<H800FormScreenEight> {
  // Part 8: Condition, Standard & Cleanliness of Food
  String? _conditionOfFood;
  String? _displayPackaging;
  String? _insectInfested;
  String? _violationOfLabeling;
  String? _separationOfUnwholesomeFood;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _conditionOfFood = widget.formData.conditionOfFood;
    _displayPackaging = widget.formData.displayPackaging;
    _insectInfested = widget.formData.insectInfested;
    _violationOfLabeling = widget.formData.violationOfLabeling;
    _separationOfUnwholesomeFood = widget.formData.separationOfUnwholesomeFood;

    // Initialize validation flags
    _isInvalid = {
      'conditionOfFood': false,
      'displayPackaging': false,
      'insectInfested': false,
      'violationOfLabeling': false,
      'separationOfUnwholesomeFood': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['conditionOfFood'] = _conditionOfFood == null;
      _isInvalid['displayPackaging'] = _displayPackaging == null;
      _isInvalid['insectInfested'] = _insectInfested == null;
      _isInvalid['violationOfLabeling'] = _violationOfLabeling == null;
      _isInvalid['separationOfUnwholesomeFood'] = _separationOfUnwholesomeFood == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.conditionOfFood = _conditionOfFood;
    widget.formData.displayPackaging = _displayPackaging;
    widget.formData.insectInfested = _insectInfested;
    widget.formData.violationOfLabeling = _violationOfLabeling;
    widget.formData.separationOfUnwholesomeFood = _separationOfUnwholesomeFood;
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
                    value: 0.8, // 8/10 of the form completed
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
                        'Part 8: Condition, Standard & Cleanliness of Food (5 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '8.1 Condition of food/Raw materials',
                        initialValue: _conditionOfFood,
                        isInvalid: _isInvalid['conditionOfFood']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfFood = value;
                            _isInvalid['conditionOfFood'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '8.2 Display/Packaging for sale/delivery',
                        initialValue: _displayPackaging,
                        isInvalid: _isInvalid['displayPackaging']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _displayPackaging = value;
                            _isInvalid['displayPackaging'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '8.3 Insect infested/Outdated food & food unfit for human consumption',
                        value: _insectInfested,
                        isInvalid: _isInvalid['insectInfested']!,
                        onChanged: (value) {
                          setState(() {
                            _insectInfested = value;
                            _isInvalid['insectInfested'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '8.4 Violation of labeling regulations',
                        value: _violationOfLabeling,
                        isInvalid: _isInvalid['violationOfLabeling']!,
                        onChanged: (value) {
                          setState(() {
                            _violationOfLabeling = value;
                            _isInvalid['violationOfLabeling'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '8.5 Separation/Storage of food that is unwholesome/outdated to be returned',
                        value: _separationOfUnwholesomeFood,
                        isInvalid: _isInvalid['separationOfUnwholesomeFood']!,
                        onChanged: (value) {
                          setState(() {
                            _separationOfUnwholesomeFood = value;
                            _isInvalid['separationOfUnwholesomeFood'] = value == null;
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
                                  '/h800_form_screen_nine',
                                  arguments: widget.formData,
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