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

  // Part 2: Building
  String? _natureOfBuilding;
  String? _space;
  String? _lightAndVentilation;
  String? _conditionOfFloor;
  String? _conditionOfWall;
  String? _conditionOfCeiling;
  String? _hasHazards;

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

    _natureOfBuilding = widget.formData.natureOfBuilding;
    _space = widget.formData.space;
    _lightAndVentilation = widget.formData.lightAndVentilation;
    _conditionOfFloor = widget.formData.conditionOfFloor;
    _conditionOfWall = widget.formData.conditionOfWall;
    _conditionOfCeiling = widget.formData.conditionOfCeiling;
    _hasHazards = widget.formData.hasHazards;

    // Initialize validation flags
    _isInvalid = {
      'suitabilityForBusiness': false,
      'generalCleanliness': false,
      'hasPollutingConditions': false,
      'hasAnimals': false,
      'hasSmokeOrAdverseEffects': false,
      'natureOfBuilding': false,
      'space': false,
      'lightAndVentilation': false,
      'conditionOfFloor': false,
      'conditionOfWall': false,
      'conditionOfCeiling': false,
      'hasHazards': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['suitabilityForBusiness'] = _suitabilityForBusiness == null;
      _isInvalid['generalCleanliness'] = _generalCleanliness == null;
      _isInvalid['hasPollutingConditions'] = _hasPollutingConditions == null;
      _isInvalid['hasAnimals'] = _hasAnimals == null;
      _isInvalid['hasSmokeOrAdverseEffects'] =
          _hasSmokeOrAdverseEffects == null;
      _isInvalid['natureOfBuilding'] = _natureOfBuilding == null;
      _isInvalid['space'] = _space == null;
      _isInvalid['lightAndVentilation'] = _lightAndVentilation == null;
      _isInvalid['conditionOfFloor'] = _conditionOfFloor == null;
      _isInvalid['conditionOfWall'] = _conditionOfWall == null;
      _isInvalid['conditionOfCeiling'] = _conditionOfCeiling == null;
      _isInvalid['hasHazards'] = _hasHazards == null;
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

    widget.formData.natureOfBuilding = _natureOfBuilding;
    widget.formData.space = _space;
    widget.formData.lightAndVentilation = _lightAndVentilation;
    widget.formData.conditionOfFloor = _conditionOfFloor;
    widget.formData.conditionOfWall = _conditionOfWall;
    widget.formData.conditionOfCeiling = _conditionOfCeiling;
    widget.formData.hasHazards = _hasHazards;
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
                  title: 'H800 Form - Screen 1',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: 0.25, // 1/4 of the form completed
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
                        'Part 1: Location & Environment (5 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '1.1 Suitability for business (1 mark)',
                        initialValue: _suitabilityForBusiness,
                        isInvalid: _isInvalid['suitabilityForBusiness']!,
                        items: const ['Suitable', 'Unsuitable'],
                        onChanged: (value) {
                          setState(() {
                            _suitabilityForBusiness = value;
                            _isInvalid['suitabilityForBusiness'] =
                                value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '1.2 General cleanliness (1 mark)',
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
                        label: '1.3 Polluting conditions (1 mark)',
                        value: _hasPollutingConditions,
                        isInvalid: _isInvalid['hasPollutingConditions']!,
                        onChanged: (value) {
                          setState(() {
                            _hasPollutingConditions = value;
                            _isInvalid['hasPollutingConditions'] =
                                value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '1.4 Presence of animals (1 mark)',
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
                        label: '1.5 Smoke or adverse effects (1 mark)',
                        value: _hasSmokeOrAdverseEffects,
                        isInvalid: _isInvalid['hasSmokeOrAdverseEffects']!,
                        onChanged: (value) {
                          setState(() {
                            _hasSmokeOrAdverseEffects = value;
                            _isInvalid['hasSmokeOrAdverseEffects'] =
                                value == null;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Part 2: Building (10 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '2.1 Nature of building (1 mark)',
                        initialValue: _natureOfBuilding,
                        isInvalid: _isInvalid['natureOfBuilding']!,
                        items: const ['Permanent', 'Temporary'],
                        onChanged: (value) {
                          setState(() {
                            _natureOfBuilding = value;
                            _isInvalid['natureOfBuilding'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '2.2 Space (1 mark)',
                        initialValue: _space,
                        isInvalid: _isInvalid['space']!,
                        items: const ['Adequate', 'Inadequate'],
                        onChanged: (value) {
                          setState(() {
                            _space = value;
                            _isInvalid['space'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '2.3 Light and ventilation (1 mark)',
                        initialValue: _lightAndVentilation,
                        isInvalid: _isInvalid['lightAndVentilation']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _lightAndVentilation = value;
                            _isInvalid['lightAndVentilation'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '2.4 Condition of floor (2 marks)',
                        initialValue: _conditionOfFloor,
                        isInvalid: _isInvalid['conditionOfFloor']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfFloor = value;
                            _isInvalid['conditionOfFloor'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '2.5 Condition of wall (2 marks)',
                        initialValue: _conditionOfWall,
                        isInvalid: _isInvalid['conditionOfWall']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfWall = value;
                            _isInvalid['conditionOfWall'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '2.6 Condition of ceiling (2 marks)',
                        initialValue: _conditionOfCeiling,
                        isInvalid: _isInvalid['conditionOfCeiling']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfCeiling = value;
                            _isInvalid['conditionOfCeiling'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '2.7 Presence of hazards (1 mark)',
                        value: _hasHazards,
                        isInvalid: _isInvalid['hasHazards']!,
                        onChanged: (value) {
                          setState(() {
                            _hasHazards = value;
                            _isInvalid['hasHazards'] = value == null;
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
