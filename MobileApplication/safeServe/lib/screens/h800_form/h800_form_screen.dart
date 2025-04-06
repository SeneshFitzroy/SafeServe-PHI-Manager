// lib/screens/h800_form/h800_form_screen.dart - for my reference
import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';
import '../register_shop/screen_one/widgets/next_button.dart';
import 'widgets/h800_form_button.dart';
import 'h800_form_data.dart';

class H800FormScreen extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreen({super.key, required this.formData});

  @override
  State<H800FormScreen> createState() => _H800FormScreenState();
}

class _H800FormScreenState extends State<H800FormScreen> {
  final ScrollController _scrollController = ScrollController();
  final Set<String> _invalidFields = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool validateFields() {
    _invalidFields.clear();

    if (widget.formData.suitabilityForBusiness.trim().isEmpty) {
      _invalidFields.add('suitabilityForBusiness');
    }
    if (widget.formData.generalCleanliness.trim().isEmpty) {
      _invalidFields.add('generalCleanliness');
    }
    if (widget.formData.natureOfBuilding.trim().isEmpty) {
      _invalidFields.add('natureOfBuilding');
    }
    if (widget.formData.space.trim().isEmpty) {
      _invalidFields.add('space');
    }
    if (widget.formData.lightAndVentilation.trim().isEmpty) {
      _invalidFields.add('lightAndVentilation');
    }
    if (widget.formData.conditionOfFloor.trim().isEmpty) {
      _invalidFields.add('conditionOfFloor');
    }
    if (widget.formData.conditionOfWall.trim().isEmpty) {
      _invalidFields.add('conditionOfWall');
    }
    if (widget.formData.conditionOfCeiling.trim().isEmpty) {
      _invalidFields.add('conditionOfCeiling');
    }

    setState(() {});
    return _invalidFields.isEmpty;
  }

  bool isFieldInvalid(String fieldKey) => _invalidFields.contains(fieldKey);

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
            controller: _scrollController,
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

                // Progress Indicator (33% for Screen 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: 0.33, // 1/3 of the form completed
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),

                // Part 1: Location & Environment
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Part 01 - Location & Environment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // 1.1 Suitability for the business
                GenericDropdown(
                  label: '1.1 Suitability for the business',
                  initialValue: widget.formData.suitabilityForBusiness,
                  isInvalid: isFieldInvalid('suitabilityForBusiness'),
                  items: const ['Suitable', 'Not Suitable'],
                  onChanged: (val) =>
                      widget.formData.suitabilityForBusiness = val,
                ),

                // 1.2 General cleanliness & tidiness
                GenericDropdown(
                  label: '1.2 General cleanliness & tidiness',
                  initialValue: widget.formData.generalCleanliness,
                  isInvalid: isFieldInvalid('generalCleanliness'),
                  items: const ['Satisfactory', 'Unsatisfactory'],
                  onChanged: (val) => widget.formData.generalCleanliness = val,
                ),

                // 1.3 Polluting conditions
                RadioButtonField(
                  label: '1.3 Polluting conditions',
                  value: widget.formData.hasPollutingConditions,
                  onChanged: (val) => setState(() {
                    widget.formData.hasPollutingConditions = val;
                  }),
                ),

                // 1.4 Dogs/Cats/Other animals
                RadioButtonField(
                  label: '1.4 Dogs/Cats/Other animals',
                  value: widget.formData.hasAnimals,
                  onChanged: (val) => setState(() {
                    widget.formData.hasAnimals = val;
                  }),
                ),

                // 1.5 Smoke or other adverse effects
                RadioButtonField(
                  label: '1.5 Smoke or other adverse effects',
                  value: widget.formData.hasSmokeOrAdverseEffects,
                  onChanged: (val) => setState(() {
                    widget.formData.hasSmokeOrAdverseEffects = val;
                  }),
                ),

                const SizedBox(height: 20),

                // Part 2: Building
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Part 2 - Building',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // 2.1 Nature of the building
                GenericDropdown(
                  label: '2.1 Nature of the building',
                  initialValue: widget.formData.natureOfBuilding,
                  isInvalid: isFieldInvalid('natureOfBuilding'),
                  items: const ['Permanent', 'Temporary'],
                  onChanged: (val) => widget.formData.natureOfBuilding = val,
                ),

                // 2.2 Space
                GenericDropdown(
                  label: '2.2 Space',
                  initialValue: widget.formData.space,
                  isInvalid: isFieldInvalid('space'),
                  items: const ['Adequate', 'Inadequate'],
                  onChanged: (val) => widget.formData.space = val,
                ),

                // 2.3 Light and ventilation
                GenericDropdown(
                  label: '2.3 Light and ventilation',
                  initialValue: widget.formData.lightAndVentilation,
                  isInvalid: isFieldInvalid('lightAndVentilation'),
                  items: const ['Good', 'Poor'],
                  onChanged: (val) => widget.formData.lightAndVentilation = val,
                ),

                // 2.4 Condition of the floor
                GenericDropdown(
                  label: '2.4 Condition of the floor',
                  initialValue: widget.formData.conditionOfFloor,
                  isInvalid: isFieldInvalid('conditionOfFloor'),
                  items: const ['Good', 'Poor'],
                  onChanged: (val) => widget.formData.conditionOfFloor = val,
                ),

                // 2.5 Condition of the wall
                GenericDropdown(
                  label: '2.5 Condition of the wall',
                  initialValue: widget.formData.conditionOfWall,
                  isInvalid: isFieldInvalid('conditionOfWall'),
                  items: const ['Good', 'Poor'],
                  onChanged: (val) => widget.formData.conditionOfWall = val,
                ),

                // 2.6 Condition of the ceiling
                GenericDropdown(
                  label: '2.6 Condition of the ceiling',
                  initialValue: widget.formData.conditionOfCeiling,
                  isInvalid: isFieldInvalid('conditionOfCeiling'),
                  items: const ['Good', 'Poor'],
                  onChanged: (val) => widget.formData.conditionOfCeiling = val,
                ),

                // 2.7 Hazards to employees/customers
                RadioButtonField(
                  label: '2.7 Hazards to employees/customers',
                  value: widget.formData.hasHazards,
                  onChanged: (val) => setState(() {
                    widget.formData.hasHazards = val;
                  }),
                ),

                const SizedBox(height: 30),

                // Next Button (using H800FormButton)
                H800FormButton(
                  label: 'Next',
                  onPressed: () {
                    if (validateFields()) {
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
