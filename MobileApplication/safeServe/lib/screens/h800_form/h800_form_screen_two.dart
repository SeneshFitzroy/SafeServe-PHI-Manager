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
  // Part 3: Area of Food Preparation/Serving/Display/Storage
  String? _generalCleanlinessPart3;
  String? _safetyMeasuresForCleanliness;
  String? _hasFlies;
  String? _hasPests;
  String? _hasFloor;
  String? _maintenanceOfWalls;
  String? _maintenanceOfCeilingPart3;
  String? _spaceInWorkingArea;
  String? _dailyCleaning;
  String? _riskOfContaminationFromToilets;
  String? _adequateBins;
  String? _hasUnnecessaryItems;
  String? _cleaningToolsAvailable;
  String? _hasObjectionableOdor;
  String? _hasOpenDrains;
  String? _areaUsedForSleeping;
  String? _separateChoppingBoards;
  String? _cleanlinessOfEquipment;
  String? _suitabilityOfLayout;
  String? _lightAndVentilationPart3;
  String? _houseKeeping;
  String? _waterSupplySuitable;
  String? _safeFoodHandling;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _generalCleanlinessPart3 = widget.formData.generalCleanlinessPart3;
    _safetyMeasuresForCleanliness = widget.formData.safetyMeasuresForCleanliness;
    _hasFlies = widget.formData.hasFlies;
    _hasPests = widget.formData.hasPests;
    _hasFloor = widget.formData.hasFloor;
    _maintenanceOfWalls = widget.formData.maintenanceOfWalls;
    _maintenanceOfCeilingPart3 = widget.formData.maintenanceOfCeilingPart3;
    _spaceInWorkingArea = widget.formData.spaceInWorkingArea;
    _dailyCleaning = widget.formData.dailyCleaning;
    _riskOfContaminationFromToilets = widget.formData.riskOfContaminationFromToilets;
    _adequateBins = widget.formData.adequateBins;
    _hasUnnecessaryItems = widget.formData.hasUnnecessaryItems;
    _cleaningToolsAvailable = widget.formData.cleaningToolsAvailable;
    _hasObjectionableOdor = widget.formData.hasObjectionableOdor;
    _hasOpenDrains = widget.formData.hasOpenDrains;
    _areaUsedForSleeping = widget.formData.areaUsedForSleeping;
    _separateChoppingBoards = widget.formData.separateChoppingBoards;
    _cleanlinessOfEquipment = widget.formData.cleanlinessOfEquipment;
    _suitabilityOfLayout = widget.formData.suitabilityOfLayout;
    _lightAndVentilationPart3 = widget.formData.lightAndVentilationPart3;
    _houseKeeping = widget.formData.houseKeeping;
    _waterSupplySuitable = widget.formData.waterSupplySuitable;
    _safeFoodHandling = widget.formData.safeFoodHandling;

    // Initialize validation flags
    _isInvalid = {
      'generalCleanlinessPart3': false,
      'safetyMeasuresForCleanliness': false,
      'hasFlies': false,
      'hasPests': false,
      'hasFloor': false,
      'maintenanceOfWalls': false,
      'maintenanceOfCeilingPart3': false,
      'spaceInWorkingArea': false,
      'dailyCleaning': false,
      'riskOfContaminationFromToilets': false,
      'adequateBins': false,
      'hasUnnecessaryItems': false,
      'cleaningToolsAvailable': false,
      'hasObjectionableOdor': false,
      'hasOpenDrains': false,
      'areaUsedForSleeping': false,
      'separateChoppingBoards': false,
      'cleanlinessOfEquipment': false,
      'suitabilityOfLayout': false,
      'lightAndVentilationPart3': false,
      'houseKeeping': false,
      'waterSupplySuitable': false,
      'safeFoodHandling': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['generalCleanlinessPart3'] = _generalCleanlinessPart3 == null;
      _isInvalid['safetyMeasuresForCleanliness'] = _safetyMeasuresForCleanliness == null;
      _isInvalid['hasFlies'] = _hasFlies == null;
      _isInvalid['hasPests'] = _hasPests == null;
      _isInvalid['hasFloor'] = _hasFloor == null;
      _isInvalid['maintenanceOfWalls'] = _maintenanceOfWalls == null;
      _isInvalid['maintenanceOfCeilingPart3'] = _maintenanceOfCeilingPart3 == null;
      _isInvalid['spaceInWorkingArea'] = _spaceInWorkingArea == null;
      _isInvalid['dailyCleaning'] = _dailyCleaning == null;
      _isInvalid['riskOfContaminationFromToilets'] = _riskOfContaminationFromToilets == null;
      _isInvalid['adequateBins'] = _adequateBins == null;
      _isInvalid['hasUnnecessaryItems'] = _hasUnnecessaryItems == null;
      _isInvalid['cleaningToolsAvailable'] = _cleaningToolsAvailable == null;
      _isInvalid['hasObjectionableOdor'] = _hasObjectionableOdor == null;
      _isInvalid['hasOpenDrains'] = _hasOpenDrains == null;
      _isInvalid['areaUsedForSleeping'] = _areaUsedForSleeping == null;
      _isInvalid['separateChoppingBoards'] = _separateChoppingBoards == null;
      _isInvalid['cleanlinessOfEquipment'] = _cleanlinessOfEquipment == null;
      _isInvalid['suitabilityOfLayout'] = _suitabilityOfLayout == null;
      _isInvalid['lightAndVentilationPart3'] = _lightAndVentilationPart3 == null;
      _isInvalid['houseKeeping'] = _houseKeeping == null;
      _isInvalid['waterSupplySuitable'] = _waterSupplySuitable == null;
      _isInvalid['safeFoodHandling'] = _safeFoodHandling == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.generalCleanlinessPart3 = _generalCleanlinessPart3;
    widget.formData.safetyMeasuresForCleanliness = _safetyMeasuresForCleanliness;
    widget.formData.hasFlies = _hasFlies;
    widget.formData.hasPests = _hasPests;
    widget.formData.hasFloor = _hasFloor;
    widget.formData.maintenanceOfWalls = _maintenanceOfWalls;
    widget.formData.maintenanceOfCeilingPart3 = _maintenanceOfCeilingPart3;
    widget.formData.spaceInWorkingArea = _spaceInWorkingArea;
    widget.formData.dailyCleaning = _dailyCleaning;
    widget.formData.riskOfContaminationFromToilets = _riskOfContaminationFromToilets;
    widget.formData.adequateBins = _adequateBins;
    widget.formData.hasUnnecessaryItems = _hasUnnecessaryItems;
    widget.formData.cleaningToolsAvailable = _cleaningToolsAvailable;
    widget.formData.hasObjectionableOdor = _hasObjectionableOdor;
    widget.formData.hasOpenDrains = _hasOpenDrains;
    widget.formData.areaUsedForSleeping = _areaUsedForSleeping;
    widget.formData.separateChoppingBoards = _separateChoppingBoards;
    widget.formData.cleanlinessOfEquipment = _cleanlinessOfEquipment;
    widget.formData.suitabilityOfLayout = _suitabilityOfLayout;
    widget.formData.lightAndVentilationPart3 = _lightAndVentilationPart3;
    widget.formData.houseKeeping = _houseKeeping;
    widget.formData.waterSupplySuitable = _waterSupplySuitable;
    widget.formData.safeFoodHandling = _safeFoodHandling;
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
                  title: 'H800 Form - Screen 2',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: 0.5, // 2/4 of the form completed
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
                        'Part 3: Area of Food Preparation/Serving/Display/Storage (30 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '3.1 General cleanliness (2 marks)',
                        initialValue: _generalCleanlinessPart3,
                        isInvalid: _isInvalid['generalCleanlinessPart3']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _generalCleanlinessPart3 = value;
                            _isInvalid['generalCleanlinessPart3'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '3.2 Safety measures for cleanliness (2 marks)',
                        initialValue: _safetyMeasuresForCleanliness,
                        isInvalid: _isInvalid['safetyMeasuresForCleanliness']!,
                        items: const ['Adequate', 'Inadequate'],
                        onChanged: (value) {
                          setState(() {
                            _safetyMeasuresForCleanliness = value;
                            _isInvalid['safetyMeasuresForCleanliness'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.3 Presence of flies (1 mark)',
                        value: _hasFlies,
                        isInvalid: _isInvalid['hasFlies']!,
                        onChanged: (value) {
                          setState(() {
                            _hasFlies = value;
                            _isInvalid['hasFlies'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.4 Presence of pests (1 mark)',
                        value: _hasPests,
                        isInvalid: _isInvalid['hasPests']!,
                        onChanged: (value) {
                          setState(() {
                            _hasPests = value;
                            _isInvalid['hasPests'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.5 Floor availability (1 mark)',
                        value: _hasFloor,
                        isInvalid: _isInvalid['hasFloor']!,
                        onChanged: (value) {
                          setState(() {
                            _hasFloor = value;
                            _isInvalid['hasFloor'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '3.6 Maintenance of walls (2 marks)',
                        initialValue: _maintenanceOfWalls,
                        isInvalid: _isInvalid['maintenanceOfWalls']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _maintenanceOfWalls = value;
                            _isInvalid['maintenanceOfWalls'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '3.7 Maintenance of ceiling (2 marks)',
                        initialValue: _maintenanceOfCeilingPart3,
                        isInvalid: _isInvalid['maintenanceOfCeilingPart3']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _maintenanceOfCeilingPart3 = value;
                            _isInvalid['maintenanceOfCeilingPart3'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '3.8 Space in working area (1 mark)',
                        initialValue: _spaceInWorkingArea,
                        isInvalid: _isInvalid['spaceInWorkingArea']!,
                        items: const ['Adequate', 'Inadequate'],
                        onChanged: (value) {
                          setState(() {
                            _spaceInWorkingArea = value;
                            _isInvalid['spaceInWorkingArea'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.9 Daily cleaning (1 mark)',
                        value: _dailyCleaning,
                        isInvalid: _isInvalid['dailyCleaning']!,
                        onChanged: (value) {
                          setState(() {
                            _dailyCleaning = value;
                            _isInvalid['dailyCleaning'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.10 Risk of contamination from toilets (1 mark)',
                        value: _riskOfContaminationFromToilets,
                        isInvalid: _isInvalid['riskOfContaminationFromToilets']!,
                        onChanged: (value) {
                          setState(() {
                            _riskOfContaminationFromToilets = value;
                            _isInvalid['riskOfContaminationFromToilets'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.11 Adequate bins (1 mark)',
                        value: _adequateBins,
                        isInvalid: _isInvalid['adequateBins']!,
                        onChanged: (value) {
                          setState(() {
                            _adequateBins = value;
                            _isInvalid['adequateBins'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.12 Unnecessary items (1 mark)',
                        value: _hasUnnecessaryItems,
                        isInvalid: _isInvalid['hasUnnecessaryItems']!,
                        onChanged: (value) {
                          setState(() {
                            _hasUnnecessaryItems = value;
                            _isInvalid['hasUnnecessaryItems'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.13 Cleaning tools available (1 mark)',
                        value: _cleaningToolsAvailable,
                        isInvalid: _isInvalid['cleaningToolsAvailable']!,
                        onChanged: (value) {
                          setState(() {
                            _cleaningToolsAvailable = value;
                            _isInvalid['cleaningToolsAvailable'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.14 Objectionable odor (1 mark)',
                        value: _hasObjectionableOdor,
                        isInvalid: _isInvalid['hasObjectionableOdor']!,
                        onChanged: (value) {
                          setState(() {
                            _hasObjectionableOdor = value;
                            _isInvalid['hasObjectionableOdor'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.15 Open drains (1 mark)',
                        value: _hasOpenDrains,
                        isInvalid: _isInvalid['hasOpenDrains']!,
                        onChanged: (value) {
                          setState(() {
                            _hasOpenDrains = value;
                            _isInvalid['hasOpenDrains'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.16 Area used for sleeping (1 mark)',
                        value: _areaUsedForSleeping,
                        isInvalid: _isInvalid['areaUsedForSleeping']!,
                        onChanged: (value) {
                          setState(() {
                            _areaUsedForSleeping = value;
                            _isInvalid['areaUsedForSleeping'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.17 Separate chopping boards (1 mark)',
                        value: _separateChoppingBoards,
                        isInvalid: _isInvalid['separateChoppingBoards']!,
                        onChanged: (value) {
                          setState(() {
                            _separateChoppingBoards = value;
                            _isInvalid['separateChoppingBoards'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.18 Cleanliness of equipment (1 mark)',
                        value: _cleanlinessOfEquipment,
                        isInvalid: _isInvalid['cleanlinessOfEquipment']!,
                        onChanged: (value) {
                          setState(() {
                            _cleanlinessOfEquipment = value;
                            _isInvalid['cleanlinessOfEquipment'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.19 Suitability of layout (1 mark)',
                        value: _suitabilityOfLayout,
                        isInvalid: _isInvalid['suitabilityOfLayout']!,
                        onChanged: (value) {
                          setState(() {
                            _suitabilityOfLayout = value;
                            _isInvalid['suitabilityOfLayout'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '3.20 Light and ventilation (1 mark)',
                        initialValue: _lightAndVentilationPart3,
                        isInvalid: _isInvalid['lightAndVentilationPart3']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _lightAndVentilationPart3 = value;
                            _isInvalid['lightAndVentilationPart3'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.21 Housekeeping (1 mark)',
                        value: _houseKeeping,
                        isInvalid: _isInvalid['houseKeeping']!,
                        onChanged: (value) {
                          setState(() {
                            _houseKeeping = value;
                            _isInvalid['houseKeeping'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.22 Water supply suitable (2 marks)',
                        value: _waterSupplySuitable,
                        isInvalid: _isInvalid['waterSupplySuitable']!,
                        onChanged: (value) {
                          setState(() {
                            _waterSupplySuitable = value;
                            _isInvalid['waterSupplySuitable'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '3.23 Safe food handling (2 marks)',
                        value: _safeFoodHandling,
                        isInvalid: _isInvalid['safeFoodHandling']!,
                        onChanged: (value) {
                          setState(() {
                            _safeFoodHandling = value;
                            _isInvalid['safeFoodHandling'] = value == null;
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