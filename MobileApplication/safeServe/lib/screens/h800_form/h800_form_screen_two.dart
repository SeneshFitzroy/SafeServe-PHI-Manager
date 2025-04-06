// lib/screens/h800_form/h800_form_screen_two.dart
import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';
import '../register_shop/screen_one/widgets/next_button.dart';
import 'widgets/h800_form_button.dart';
import 'h800_form_data.dart';

class H800FormScreenTwo extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreenTwo({super.key, required this.formData});

  @override
  State<H800FormScreenTwo> createState() => _H800FormScreenTwoState();
}

class _H800FormScreenTwoState extends State<H800FormScreenTwo> {
  final ScrollController _scrollController = ScrollController();
  final Set<String> _invalidFields = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool validateFields() {
    _invalidFields.clear();

    // Validate dropdown fields
    if (widget.formData.generalCleanlinessPart3.trim().isEmpty) {
      _invalidFields.add('generalCleanlinessPart3');
    }
    if (widget.formData.safetyMeasuresForCleanliness.trim().isEmpty) {
      _invalidFields.add('safetyMeasuresForCleanliness');
    }
    if (widget.formData.dailyCleaning.trim().isEmpty) {
      _invalidFields.add('dailyCleaning');
    }
    if (widget.formData.spaceInWorkingArea.trim().isEmpty) {
      _invalidFields.add('spaceInWorkingArea');
    }
    if (widget.formData.maintenanceOfWalls.trim().isEmpty) {
      _invalidFields.add('maintenanceOfWalls');
    }
    if (widget.formData.maintenanceOfCeilingPart3.trim().isEmpty) {
      _invalidFields.add('maintenanceOfCeilingPart3');
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

                // Progress Indicator (66% for Screen 2)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: 0.66, // 2/3 of the form completed
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),

                // Part 3: Area of Food Preparation/Serving/Display/Storage
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Part 3 - Area of Food Preparation/Serving/Display/Storage',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // 3.1 General cleanliness
                GenericDropdown(
                  label: '3.1 General cleanliness',
                  initialValue: widget.formData.generalCleanlinessPart3,
                  isInvalid: isFieldInvalid('generalCleanlinessPart3'),
                  items: const ['Satisfactory', 'Unsatisfactory'],
                  onChanged: (val) =>
                      widget.formData.generalCleanlinessPart3 = val,
                ),

                // 3.2 Safety measures for cleanliness
                GenericDropdown(
                  label: '3.2 Safety measures for cleanliness',
                  initialValue: widget.formData.safetyMeasuresForCleanliness,
                  isInvalid: isFieldInvalid('safetyMeasuresForCleanliness'),
                  items: const ['Adequate', 'Inadequate'],
                  onChanged: (val) =>
                      widget.formData.safetyMeasuresForCleanliness = val,
                ),

                // 3.3 Flies
                RadioButtonField(
                  label: '3.3 Flies',
                  value: widget.formData.hasFlies,
                  onChanged: (val) => setState(() {
                    widget.formData.hasFlies = val;
                  }),
                ),

                // 3.4 Ants/Cockroaches/Rodents and other disease carriers
                RadioButtonField(
                  label:
                      '3.4 Ants/Cockroaches/Rodents and other disease carriers',
                  value: widget.formData.hasPests,
                  onChanged: (val) => setState(() {
                    widget.formData.hasPests = val;
                  }),
                ),

                // 3.5 Presence of floor
                RadioButtonField(
                  label: '3.5 Presence of floor',
                  value: widget.formData.hasFloor,
                  onChanged: (val) => setState(() {
                    widget.formData.hasFloor = val;
                  }),
                ),

                // 3.6 Maintenance of walls
                GenericDropdown(
                  label: '3.6 Maintenance of walls',
                  initialValue: widget.formData.maintenanceOfWalls,
                  isInvalid: isFieldInvalid('maintenanceOfWalls'),
                  items: const ['Good', 'Poor'],
                  onChanged: (val) => widget.formData.maintenanceOfWalls = val,
                ),

                // 3.7 Maintenance of ceiling
                GenericDropdown(
                  label: '3.7 Maintenance of ceiling',
                  initialValue: widget.formData.maintenanceOfCeilingPart3,
                  isInvalid: isFieldInvalid('maintenanceOfCeilingPart3'),
                  items: const ['Good', 'Poor'],
                  onChanged: (val) =>
                      widget.formData.maintenanceOfCeilingPart3 = val,
                ),

                // 3.8 Space in the working area
                GenericDropdown(
                  label: '3.8 Space in the working area',
                  initialValue: widget.formData.spaceInWorkingArea,
                  isInvalid: isFieldInvalid('spaceInWorkingArea'),
                  items: const ['Adequate', 'Inadequate'],
                  onChanged: (val) => widget.formData.spaceInWorkingArea = val,
                ),

                // 3.9 Daily cleaning
                GenericDropdown(
                  label: '3.9 Daily cleaning',
                  initialValue: widget.formData.dailyCleaning,
                  isInvalid: isFieldInvalid('dailyCleaning'),
                  items: const ['Yes', 'No'],
                  onChanged: (val) => widget.formData.dailyCleaning = val,
                ),

                // 3.10 Risk of contamination from toilets
                RadioButtonField(
                  label: '3.10 Risk of contamination from toilets',
                  value: widget.formData.riskOfContaminationFromToilets,
                  onChanged: (val) => setState(() {
                    widget.formData.riskOfContaminationFromToilets = val;
                  }),
                ),

                // 3.11 Adequate number of bins with lids for waste disposal
                RadioButtonField(
                  label:
                      '3.11 Adequate number of bins with lids for waste disposal',
                  value: widget.formData.adequateBins,
                  onChanged: (val) => setState(() {
                    widget.formData.adequateBins = val;
                  }),
                ),

                // 3.12 Empty boxes/Gunny bags and other unnecessary items
                RadioButtonField(
                  label:
                      '3.12 Empty boxes/Gunny bags and other unnecessary items',
                  value: widget.formData.hasUnnecessaryItems,
                  onChanged: (val) => setState(() {
                    widget.formData.hasUnnecessaryItems = val;
                  }),
                ),

                // 3.13 Availability of cleaning tools/materials/serviettes etc.
                RadioButtonField(
                  label:
                      '3.13 Availability of cleaning tools/materials/serviettes etc.',
                  value: widget.formData.cleaningToolsAvailable,
                  onChanged: (val) => setState(() {
                    widget.formData.cleaningToolsAvailable = val;
                  }),
                ),

                // 3.14 Objectionable odor
                RadioButtonField(
                  label: '3.14 Objectionable odor',
                  value: widget.formData.hasObjectionableOdor,
                  onChanged: (val) => setState(() {
                    widget.formData.hasObjectionableOdor = val;
                  }),
                ),

                // 3.15 Open drains and stagnant waste water
                RadioButtonField(
                  label: '3.15 Open drains and stagnant waste water',
                  value: widget.formData.hasOpenDrains,
                  onChanged: (val) => setState(() {
                    widget.formData.hasOpenDrains = val;
                  }),
                ),

                // 3.16 Area used for sleeping or any other unrelated activities
                RadioButtonField(
                  label:
                      '3.16 Area used for sleeping or any other unrelated activities',
                  value: widget.formData.areaUsedForSleeping,
                  onChanged: (val) => setState(() {
                    widget.formData.areaUsedForSleeping = val;
                  }),
                ),

                // 3.17 Use of separate chopping boards/knives etc.
                RadioButtonField(
                  label: '3.17 Use of separate chopping boards/knives etc.',
                  value: widget.formData.separateChoppingBoards,
                  onChanged: (val) => setState(() {
                    widget.formData.separateChoppingBoards = val;
                  }),
                ),

                // 3.18 Cleanliness of equipment/utensils
                RadioButtonField(
                  label: '3.18 Cleanliness of equipment/utensils',
                  value: widget.formData.cleanlinessOfEquipment,
                  onChanged: (val) => setState(() {
                    widget.formData.cleanlinessOfEquipment = val;
                  }),
                ),

                // 3.19 Suitability of the layout of the area for the process
                RadioButtonField(
                  label:
                      '3.19 Suitability of the layout of the area for the process',
                  value: widget.formData.suitabilityOfLayout,
                  onChanged: (val) => setState(() {
                    widget.formData.suitabilityOfLayout = val;
                  }),
                ),

                // 3.20 Light and ventilation
                GenericDropdown(
                  label: '3.20 Light and ventilation',
                  initialValue: widget.formData.lightAndVentilationPart3,
                  isInvalid: isFieldInvalid('lightAndVentilationPart3'),
                  items: const ['Good', 'Poor'],
                  onChanged: (val) =>
                      widget.formData.lightAndVentilationPart3 = val,
                ),

                // 3.21 House keeping
                RadioButtonField(
                  label: '3.21 House keeping',
                  value: widget.formData.houseKeeping,
                  onChanged: (val) => setState(() {
                    widget.formData.houseKeeping = val;
                  }),
                ),

                // 3.22 Water supplied for different tasks in a suitable manner
                RadioButtonField(
                  label:
                      '3.22 Water supplied for different tasks in a suitable manner',
                  value: widget.formData.waterSupplySuitable,
                  onChanged: (val) => setState(() {
                    widget.formData.waterSupplySuitable = val;
                  }),
                ),

                const SizedBox(height: 30),

                // Previous and Next Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H800FormButton(
                      label: 'Previous',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    H800FormButton(
                      label: 'Next',
                      onPressed: () {
                        if (validateFields()) {
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
