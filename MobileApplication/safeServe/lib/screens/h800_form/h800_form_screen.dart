import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreen extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreen({super.key, required this.formData});

  @override
  H800FormScreenState createState() => H800FormScreenState();
}

class H800FormScreenState extends State<H800FormScreen> {
  // Part 1: Location & Environment
  String? _suitabilityForBusiness;
  String? _generalCleanliness;
  String? _hasPollutingConditions;
  String? _hasAnimals;
  String? _hasSmokeOrAdverseEffects;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _suitabilityForBusiness = widget.formData.suitabilityForBusiness;
    _generalCleanliness = widget.formData.generalCleanliness;
    _hasPollutingConditions = widget.formData.hasPollutingConditions;
    _hasAnimals = widget.formData.hasAnimals;
    _hasSmokeOrAdverseEffects = widget.formData.hasSmokeOrAdverseEffects;

    // Initialize validation flags
    _isInvalid = {
      'suitabilityForBusiness': false,
      'generalCleanliness': false,
      'hasPollutingConditions': false,
      'hasAnimals': false,
      'hasSmokeOrAdverseEffects': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['suitabilityForBusiness'] = _suitabilityForBusiness == null;
      _isInvalid['generalCleanliness'] = _generalCleanliness == null;
      _isInvalid['hasPollutingConditions'] = _hasPollutingConditions == null;
      _isInvalid['hasAnimals'] = _hasAnimals == null;
      _isInvalid['hasSmokeOrAdverseEffects'] = _hasSmokeOrAdverseEffects == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.suitabilityForBusiness = _suitabilityForBusiness;
    widget.formData.generalCleanliness = _generalCleanliness;
    widget.formData.hasPollutingConditions = _hasPollutingConditions;
    widget.formData.hasAnimals = _hasAnimals;
    widget.formData.hasSmokeOrAdverseEffects = _hasSmokeOrAdverseEffects;
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
                    value: 0.1, // 1/10 of the form completed
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
                        'Part 1: Location & Environment (5 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '1.1 Suitability for business',
                        initialValue: _suitabilityForBusiness,
                        isInvalid: _isInvalid['suitabilityForBusiness']!,
                        items: const ['Suitable', 'Unsuitable'],
                        onChanged: (value) {
                          setState(() {
                            _suitabilityForBusiness = value;
                            _isInvalid['suitabilityForBusiness'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '1.2 General cleanliness & tidiness',
                        initialValue: _generalCleanliness,
                        isInvalid: _isInvalid['generalCleanliness']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _generalCleanliness = value;
                            _isInvalid['generalCleanliness'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '1.3 Polluting conditions',
                        value: _hasPollutingConditions,
                        isInvalid: _isInvalid['hasPollutingConditions']!,
                        onChanged: (value) {
                          setState(() {
                            _hasPollutingConditions = value;
                            _isInvalid['hasPollutingConditions'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '1.4 Dogs/Cats/Other animals',
                        value: _hasAnimals,
                        isInvalid: _isInvalid['hasAnimals']!,
                        onChanged: (value) {
                          setState(() {
                            _hasAnimals = value;
                            _isInvalid['hasAnimals'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '1.5 Smoke or other adverse effects',
                        value: _hasSmokeOrAdverseEffects,
                        isInvalid: _isInvalid['hasSmokeOrAdverseEffects']!,
                        onChanged: (value) {
                          setState(() {
                            _hasSmokeOrAdverseEffects = value;
                            _isInvalid['hasSmokeOrAdverseEffects'] = value == null;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      H800FormButton(
                        label: 'Next',
                        onPressed: () {
                          if (_validateForm()) {
                            _updateFormData();
                            Navigator.pushNamed(
                              context,
                              '/h800_form_screen_two',
                              arguments: widget.formData,
                            );
                          }
                        },
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