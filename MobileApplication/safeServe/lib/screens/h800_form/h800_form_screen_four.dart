import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenFour extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreenFour({super.key, required this.formData});

  @override
  H800FormScreenFourState createState() => H800FormScreenFourState();
}

class H800FormScreenFourState extends State<H800FormScreenFour> {
  // Part 4: Equipment & Furniture
  String? _equipmentForFoodHandling;
  String? _conditionOfEquipment;
  String? _cleanOfEquipment;
  String? _foodTongsAvailable;
  String? _storageCleanEquip;
  String? _suitableSafetyofFurniture;
  String? _furnitureCondition;
  String? _cleaningAndMaintenanceOfFurniture;
  String? _maintenanceOfRefrigerators;
  String? _cleanandMaintenanceOfRefrigerators;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _equipmentForFoodHandling = widget.formData.equipmentForFoodHandling;
    _conditionOfEquipment = widget.formData.conditionOfEquipment;
    _cleanOfEquipment = widget.formData.cleanOfEquipment;
    _foodTongsAvailable = widget.formData.foodTongsAvailable;
    _storageCleanEquip = widget.formData.storageCleanEquip;
    _suitableSafetyofFurniture = widget.formData.suitableSafetyofFurniture;
    _furnitureCondition = widget.formData.furnitureCondition;
    _cleaningAndMaintenanceOfFurniture = widget.formData.cleaningAndMaintenanceOfFurniture;
    _maintenanceOfRefrigerators = widget.formData.maintenanceOfRefrigerators;
    _cleanandMaintenanceOfRefrigerators = widget.formData.cleanandMaintenanceOfRefrigerators;

    // Initialize validation flags
    _isInvalid = {
      'equipmentForFoodHandling': false,
      'conditionOfEquipment': false,
      'cleanOfEquipment': false,
      'foodTongsAvailable': false,
      'storageCleanEquip': false,
      'suitableSafetyofFurniture': false,
      'furnitureCondition': false,
      'cleaningAndMaintenanceOfFurniture': false,
      'maintenanceOfRefrigerators': false,
      'cleanandMaintenanceOfRefrigerators': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['equipmentForFoodHandling'] = _equipmentForFoodHandling == null;
      _isInvalid['conditionOfEquipment'] = _conditionOfEquipment == null;
      _isInvalid['cleanOfEquipment'] = _cleanOfEquipment == null;
      _isInvalid['foodTongsAvailable'] = _foodTongsAvailable == null;
      _isInvalid['storageCleanEquip'] = _storageCleanEquip == null;
      _isInvalid['suitableSafetyofFurniture'] = _suitableSafetyofFurniture == null;
      _isInvalid['furnitureCondition'] = _furnitureCondition == null;
      _isInvalid['cleaningAndMaintenanceOfFurniture'] = _cleaningAndMaintenanceOfFurniture == null;
      _isInvalid['maintenanceOfRefrigerators'] = _maintenanceOfRefrigerators == null;
      _isInvalid['cleanandMaintenanceOfRefrigerators'] = _cleanandMaintenanceOfRefrigerators == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.equipmentForFoodHandling = _equipmentForFoodHandling;
    widget.formData.conditionOfEquipment = _conditionOfEquipment;
    widget.formData.cleanOfEquipment = _cleanOfEquipment;
    widget.formData.foodTongsAvailable = _foodTongsAvailable;
    widget.formData.storageCleanEquip = _storageCleanEquip;
    widget.formData.suitableSafetyofFurniture = _suitableSafetyofFurniture;
    widget.formData.furnitureCondition = _furnitureCondition;
    widget.formData.cleaningAndMaintenanceOfFurniture = _cleaningAndMaintenanceOfFurniture;
    widget.formData.maintenanceOfRefrigerators = _maintenanceOfRefrigerators;
    widget.formData.cleanandMaintenanceOfRefrigerators = _cleanandMaintenanceOfRefrigerators;
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
                    value: 0.4, // 4/10 of the form completed
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
                        label: '4.1 Equipment/utensils for food handling',
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
                        label: '4.2 Condition of equipment/utensils',
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
                      GenericDropdown(
                        label: '4.3 Cleanliness of equipment/utensils',
                        initialValue: _cleanOfEquipment,
                        isInvalid: _isInvalid['cleanOfEquipment']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _cleanOfEquipment = value;
                            _isInvalid['cleanOfEquipment'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '4.4 Availability of food tongs/spoons to serve food items',
                        value: _foodTongsAvailable,
                        isInvalid: _isInvalid['foodTongsAvailable']!,
                        onChanged: (value) {
                          setState(() {
                            _foodTongsAvailable = value;
                            _isInvalid['foodTongsAvailable'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '4.5 Storage facilities for cleaned equipment',
                        value: _storageCleanEquip,
                        isInvalid: _isInvalid['storageCleanEquip']!,
                        onChanged: (value) {
                          setState(() {
                            _storageCleanEquip = value;
                            _isInvalid['storageCleanEquip'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '4.6 Furniture- Tables/Chairs/Cupboards/Racks etc.',
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
                        label: '4.7 Suitability for required purpose and safety of furniture',
                        initialValue: _suitableSafetyofFurniture,
                        isInvalid: _isInvalid['suitableSafetyofFurniture']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _suitableSafetyofFurniture = value;
                            _isInvalid['suitableSafetyofFurniture'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '4.8 Cleaning and maintenance of furniture',
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
                        label: '4.9 Maintenance of temperature in refrigerators/deep freezers',
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
                      GenericDropdown(
                        label: '4.10 Cleanliness & maintenance of refrigerators/deep freezers',
                        initialValue: _cleanandMaintenanceOfRefrigerators,
                        isInvalid: _isInvalid['cleanandMaintenanceOfRefrigerators']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _cleanandMaintenanceOfRefrigerators = value;
                            _isInvalid['cleanandMaintenanceOfRefrigerators'] = value == null;
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
                                  '/h800_form_screen_five',
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