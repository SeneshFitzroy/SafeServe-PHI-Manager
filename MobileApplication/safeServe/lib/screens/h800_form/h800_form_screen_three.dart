import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenThree extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreenThree({super.key, required this.formData});

  @override
  H800FormScreenThreeState createState() => H800FormScreenThreeState();
}

class H800FormScreenThreeState extends State<H800FormScreenThree> {
  // Part 4: Equipment & Furniture
  String? _equipmentForFoodHandling;
  String? _conditionOfEquipment;
  String? _foodTongsAvailable;
  String? _furnitureCondition;
  String? _cleaningAndMaintenanceOfFurniture;
  String? _maintenanceOfRefrigerators;

  // Part 5: Storage
  String? _storageFacilities;
  String? _storageOfRawMaterials;
  String? _storageOfCookedFood;
  String? _storageInRefrigerator;
  String? _measuresToPreventContamination;

  // Part 6: Water Supply
  String? _waterSource;
  String? _waterDispensedThroughTaps;
  String? _waterSafetyCertified;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _equipmentForFoodHandling = widget.formData.equipmentForFoodHandling;
    _conditionOfEquipment = widget.formData.conditionOfEquipment;
    _foodTongsAvailable = widget.formData.foodTongsAvailable;
    _furnitureCondition = widget.formData.furnitureCondition;
    _cleaningAndMaintenanceOfFurniture = widget.formData.cleaningAndMaintenanceOfFurniture;
    _maintenanceOfRefrigerators = widget.formData.maintenanceOfRefrigerators;

    _storageFacilities = widget.formData.storageFacilities;
    _storageOfRawMaterials = widget.formData.storageOfRawMaterials;
    _storageOfCookedFood = widget.formData.storageOfCookedFood;
    _storageInRefrigerator = widget.formData.storageInRefrigerator;
    _measuresToPreventContamination = widget.formData.measuresToPreventContamination;

    _waterSource = widget.formData.waterSource;
    _waterDispensedThroughTaps = widget.formData.waterDispensedThroughTaps;
    _waterSafetyCertified = widget.formData.waterSafetyCertified;

    // Initialize validation flags
    _isInvalid = {
      'equipmentForFoodHandling': false,
      'conditionOfEquipment': false,
      'foodTongsAvailable': false,
      'furnitureCondition': false,
      'cleaningAndMaintenanceOfFurniture': false,
      'maintenanceOfRefrigerators': false,
      'storageFacilities': false,
      'storageOfRawMaterials': false,
      'storageOfCookedFood': false,
      'storageInRefrigerator': false,
      'measuresToPreventContamination': false,
      'waterSource': false,
      'waterDispensedThroughTaps': false,
      'waterSafetyCertified': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['equipmentForFoodHandling'] = _equipmentForFoodHandling == null;
      _isInvalid['conditionOfEquipment'] = _conditionOfEquipment == null;
      _isInvalid['foodTongsAvailable'] = _foodTongsAvailable == null;
      _isInvalid['furnitureCondition'] = _furnitureCondition == null;
      _isInvalid['cleaningAndMaintenanceOfFurniture'] = _cleaningAndMaintenanceOfFurniture == null;
      _isInvalid['maintenanceOfRefrigerators'] = _maintenanceOfRefrigerators == null;
      _isInvalid['storageFacilities'] = _storageFacilities == null;
      _isInvalid['storageOfRawMaterials'] = _storageOfRawMaterials == null;
      _isInvalid['storageOfCookedFood'] = _storageOfCookedFood == null;
      _isInvalid['storageInRefrigerator'] = _storageInRefrigerator == null;
      _isInvalid['measuresToPreventContamination'] = _measuresToPreventContamination == null;
      _isInvalid['waterSource'] = _waterSource == null;
      _isInvalid['waterDispensedThroughTaps'] = _waterDispensedThroughTaps == null;
      _isInvalid['waterSafetyCertified'] = _waterSafetyCertified == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.equipmentForFoodHandling = _equipmentForFoodHandling;
    widget.formData.conditionOfEquipment = _conditionOfEquipment;
    widget.formData.foodTongsAvailable = _foodTongsAvailable;
    widget.formData.furnitureCondition = _furnitureCondition;
    widget.formData.cleaningAndMaintenanceOfFurniture = _cleaningAndMaintenanceOfFurniture;
    widget.formData.maintenanceOfRefrigerators = _maintenanceOfRefrigerators;

    widget.formData.storageFacilities = _storageFacilities;
    widget.formData.storageOfRawMaterials = _storageOfRawMaterials;
    widget.formData.storageOfCookedFood = _storageOfCookedFood;
    widget.formData.storageInRefrigerator = _storageInRefrigerator;
    widget.formData.measuresToPreventContamination = _measuresToPreventContamination;

    widget.formData.waterSource = _waterSource;
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
                  title: 'H800 Form - Screen 3',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: 0.75, // 3/4 of the form completed
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
                        'Part 4: Equipment & Furniture (10 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '4.1 Equipment for food handling (1 mark)',
                        initialValue: _equipmentForFoodHandling,
                        isInvalid: _isInvalid['equipmentForFoodHandling']!,
                        items: const ['Adequate', 'Inadequate'],
                        onChanged: (value) {
                          setState(() {
                            _equipmentForFoodHandling = value;
                            _isInvalid['equipmentForFoodHandling'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '4.2 Condition of equipment (1 mark)',
                        initialValue: _conditionOfEquipment,
                        isInvalid: _isInvalid['conditionOfEquipment']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfEquipment = value;
                            _isInvalid['conditionOfEquipment'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '4.3 Food tongs available (1 mark)',
                        value: _foodTongsAvailable,
                        isInvalid: _isInvalid['foodTongsAvailable']!,
                        onChanged: (value) {
                          setState(() {
                            _foodTongsAvailable = value;
                            _isInvalid['foodTongsAvailable'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '4.4 Furniture condition (1 mark)',
                        initialValue: _furnitureCondition,
                        isInvalid: _isInvalid['furnitureCondition']!,
                        items: const ['Adequate', 'Inadequate'],
                        onChanged: (value) {
                          setState(() {
                            _furnitureCondition = value;
                            _isInvalid['furnitureCondition'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '4.5 Cleaning and maintenance of furniture (1 mark)',
                        initialValue: _cleaningAndMaintenanceOfFurniture,
                        isInvalid: _isInvalid['cleaningAndMaintenanceOfFurniture']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _cleaningAndMaintenanceOfFurniture = value;
                            _isInvalid['cleaningAndMaintenanceOfFurniture'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '4.6 Maintenance of refrigerators (1 mark)',
                        initialValue: _maintenanceOfRefrigerators,
                        isInvalid: _isInvalid['maintenanceOfRefrigerators']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _maintenanceOfRefrigerators = value;
                            _isInvalid['maintenanceOfRefrigerators'] = value == null;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Part 5: Storage (10 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '5.1 Storage facilities (2 marks)',
                        initialValue: _storageFacilities,
                        isInvalid: _isInvalid['storageFacilities']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _storageFacilities = value;
                            _isInvalid['storageFacilities'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '5.2 Storage of raw materials (2 marks)',
                        initialValue: _storageOfRawMaterials,
                        isInvalid: _isInvalid['storageOfRawMaterials']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _storageOfRawMaterials = value;
                            _isInvalid['storageOfRawMaterials'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '5.3 Storage of cooked food (2 marks)',
                        initialValue: _storageOfCookedFood,
                        isInvalid: _isInvalid['storageOfCookedFood']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _storageOfCookedFood = value;
                            _isInvalid['storageOfCookedFood'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '5.4 Storage in refrigerator (1 mark)',
                        initialValue: _storageInRefrigerator,
                        isInvalid: _isInvalid['storageInRefrigerator']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _storageInRefrigerator = value;
                            _isInvalid['storageInRefrigerator'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '5.5 Measures to prevent contamination (2 marks)',
                        initialValue: _measuresToPreventContamination,
                        isInvalid: _isInvalid['measuresToPreventContamination']!,
                        items: const ['Good', 'Poor'],
                        onChanged: (value) {
                          setState(() {
                            _measuresToPreventContamination = value;
                            _isInvalid['measuresToPreventContamination'] = value == null;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Part 6: Water Supply (5 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '6.1 Water source (1 mark)',
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
                      RadioButtonField(
                        label: '6.2 Water dispensed through taps (1 mark)',
                        value: _waterDispensedThroughTaps,
                        isInvalid: _isInvalid['waterDispensedThroughTaps']!,
                        onChanged: (value) {
                          setState(() {
                            _waterDispensedThroughTaps = value;
                            _isInvalid['waterDispensedThroughTaps'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '6.3 Water safety certified (2 marks)',
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
                                  '/h800_form_screen_four',
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