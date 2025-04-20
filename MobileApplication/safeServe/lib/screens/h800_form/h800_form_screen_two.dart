import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenTwo extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreenTwo({super.key, required this.formData});

  @override
  H800FormScreenTwoState createState() => H800FormScreenTwoState();
}

class H800FormScreenTwoState extends State<H800FormScreenTwo> {
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
    _natureOfBuilding = widget.formData.natureOfBuilding;
    _space = widget.formData.space;
    _lightAndVentilation = widget.formData.lightAndVentilation;
    _conditionOfFloor = widget.formData.conditionOfFloor;
    _conditionOfWall = widget.formData.conditionOfWall;
    _conditionOfCeiling = widget.formData.conditionOfCeiling;
    _hasHazards = widget.formData.hasHazards;

    // Initialize validation flags
    _isInvalid = {
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
                  title: 'H800 Form',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: 0.2, // 2/10 of the form completed
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
                        'Part 2: Building (10 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '2.1 Nature of the building',
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
                        label: '2.2 Space',
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
                        label: '2.3 Light and ventilation',
                        initialValue: _lightAndVentilation,
                        isInvalid: _isInvalid['lightAndVentilation']!,
                        items: const ['Adequate', 'Inadequate'],
                        onChanged: (value) {
                          setState(() {
                            _lightAndVentilation = value;
                            _isInvalid['lightAndVentilation'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '2.4 Condition of the floor',
                        initialValue: _conditionOfFloor,
                        isInvalid: _isInvalid['conditionOfFloor']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfFloor = value;
                            _isInvalid['conditionOfFloor'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '2.5 Condition of the wall',
                        initialValue: _conditionOfWall,
                        isInvalid: _isInvalid['conditionOfWall']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfWall = value;
                            _isInvalid['conditionOfWall'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '2.6 Condition of the ceiling',
                        initialValue: _conditionOfCeiling,
                        isInvalid: _isInvalid['conditionOfCeiling']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfCeiling = value;
                            _isInvalid['conditionOfCeiling'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '2.7 Hazards to employees/customers',
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
                                  '/h800_form_screen_three',
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