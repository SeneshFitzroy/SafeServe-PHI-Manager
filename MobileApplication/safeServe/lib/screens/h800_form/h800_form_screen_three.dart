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
  String? _cleanOfEquipment;
  String? _foodTongsAvailable;
  String? _storageCleanEquip;
  String? _suitableSafetyofFurniture;
  String? _furnitureCondition;
  String? _cleaningAndMaintenanceOfFurniture;
  String? _maintenanceOfRefrigerators;
  String? _cleanandMaintenanceOfRefrigerators;

  // Part 5: Storage
  String? _storageFacilities;
  String? _storageOfRawMaterials;
  String? _storageOfCookedFood;
  String? _foodStoredTemp;
  String? _storageInRefrigerator;
  String? _measuresToPreventContamination;

  // Part 6: Water Supply
  String? _waterSource;
  String? _waterStorageMethod;
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
    _cleanOfEquipment = widget.formData.cleanOfEquipment;
    _foodTongsAvailable = widget.formData.foodTongsAvailable;
    _storageCleanEquip = widget.formData.storageCleanEquip;
    _suitableSafetyofFurniture = widget.formData.suitableSafetyofFurniture;
    _furnitureCondition = widget.formData.furnitureCondition;
    _cleaningAndMaintenanceOfFurniture = widget.formData.cleaningAndMaintenanceOfFurniture;
    _maintenanceOfRefrigerators = widget.formData.maintenanceOfRefrigerators;
    _cleanandMaintenanceOfRefrigerators = widget.formData.cleanandMaintenanceOfRefrigerators;

    _storageFacilities = widget.formData.storageFacilities;
    _storageOfRawMaterials = widget.formData.storageOfRawMaterials;
    _storageOfCookedFood = widget.formData.storageOfCookedFood;
    _foodStoredTemp = widget.formData.foodStoredTemp;
    _storageInRefrigerator = widget.formData.storageInRefrigerator;
    _measuresToPreventContamination = widget.formData.measuresToPreventContamination;

    _waterSource = widget.formData.waterSource;
    _waterStorageMethod = widget.formData.waterStorageMethod;
    _waterDispensedThroughTaps = widget.formData.waterDispensedThroughTaps;
    _waterSafetyCertified = widget.formData.waterSafetyCertified;

    // Initialize validation flags
    _isInvalid = {
      'equipmentForFoodHandling': false,
      'conditionOfEquipment': false,
      'cleanOfEquipment':false,
      'foodTongsAvailable': false,
      'storageCleanEquip':false,
      'suitableSafetyofFurniture': false,
      'furnitureCondition': false,
      'cleaningAndMaintenanceOfFurniture': false,
      'maintenanceOfRefrigerators': false,
      'cleanandMaintenanceOfRefrigerators': false,
      'storageFacilities': false,
      'storageOfRawMaterials': false,
      'storageOfCookedFood': false,
      'foodStoredTemp':false,
      'storageInRefrigerator': false,
      'measuresToPreventContamination': false,
      'waterSource': false,
      'waterStorageMethod':false,
      'waterDispensedThroughTaps': false,
      'waterSafetyCertified': false,
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
      _isInvalid['suitableSafetyofFurniture'] =_suitableSafetyofFurniture == null;
      _isInvalid['furnitureCondition'] = _furnitureCondition == null;
      _isInvalid['cleaningAndMaintenanceOfFurniture'] = _cleaningAndMaintenanceOfFurniture == null;
      _isInvalid['maintenanceOfRefrigerators'] = _maintenanceOfRefrigerators == null;
      _isInvalid ['cleanandMaintenanceOfRefrigerators']= _cleanandMaintenanceOfRefrigerators == null;
      _isInvalid['storageFacilities'] = _storageFacilities == null;
      _isInvalid['storageOfRawMaterials'] = _storageOfRawMaterials == null;
      _isInvalid['storageOfCookedFood'] = _storageOfCookedFood == null;
      _isInvalid['foodStoredTemp']=_foodStoredTemp ==null;
      _isInvalid['storageInRefrigerator'] = _storageInRefrigerator == null;
      _isInvalid['measuresToPreventContamination'] = _measuresToPreventContamination == null;
      _isInvalid['waterSource'] = _waterSource == null;
      _isInvalid['waterStorageMethod']= _waterStorageMethod ==null;
      _isInvalid['waterDispensedThroughTaps'] = _waterDispensedThroughTaps == null;
      _isInvalid['waterSafetyCertified'] = _waterSafetyCertified == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.equipmentForFoodHandling = _equipmentForFoodHandling;
    widget.formData.conditionOfEquipment = _conditionOfEquipment;
    widget.formData.cleanOfEquipment= _cleanOfEquipment;
    widget.formData.foodTongsAvailable = _foodTongsAvailable;
    widget.formData.storageCleanEquip = _storageCleanEquip;
    widget.formData.suitableSafetyofFurniture = _suitableSafetyofFurniture;
    widget.formData.furnitureCondition = _furnitureCondition;
    widget.formData.cleaningAndMaintenanceOfFurniture = _cleaningAndMaintenanceOfFurniture;
    widget.formData.maintenanceOfRefrigerators = _maintenanceOfRefrigerators;
    widget.formData.cleanandMaintenanceOfRefrigerators = _cleanandMaintenanceOfRefrigerators;

    widget.formData.storageFacilities = _storageFacilities;
    widget.formData.storageOfRawMaterials = _storageOfRawMaterials;
    widget.formData.storageOfCookedFood = _storageOfCookedFood;
    widget.formData.storageInRefrigerator = _storageInRefrigerator;
    widget.formData.measuresToPreventContamination = _measuresToPreventContamination;

    widget.formData.waterSource = _waterSource;
    widget.formData.waterStorageMethod = _waterStorageMethod;
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
                  title: 'H800 Form',
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
                      RadioButtonField(//new
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
                      GenericDropdown(//new
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
                      GenericDropdown(//new
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
                      const Text(
                        'Part 5: Storage (10 Marks)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '5.1 Storage facilities and housekeeping',
                        initialValue: _storageFacilities,
                        isInvalid: _isInvalid['storageFacilities']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _storageFacilities = value;
                            _isInvalid['storageFacilities'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '5.2 Storage of raw materials',
                        initialValue: _storageOfRawMaterials,
                        isInvalid: _isInvalid['storageOfRawMaterials']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _storageOfRawMaterials = value;
                            _isInvalid['storageOfRawMaterials'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '5.3 Storage of cooked/partially cooked/prepared food',
                        initialValue: _storageOfCookedFood,
                        isInvalid: _isInvalid['storageOfCookedFood']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _storageOfCookedFood = value;
                            _isInvalid['storageOfCookedFood'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(//new
                        label: '5.4 Food stored under suitable temperature',
                        value: _foodStoredTemp,
                        isInvalid: _isInvalid['foodStoredTemp']!,
                        onChanged: (value) {
                          setState(() {
                            _foodStoredTemp = value;
                            _isInvalid['foodStoredTemp'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '5.5 Storage of food in refrigerator/deep freezer',
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
                        label: '5.6 Measures taken to prevent contamination during food storage',
                        initialValue: _measuresToPreventContamination,
                        isInvalid: _isInvalid['measuresToPreventContamination']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
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
                        label: '6.1 Water source',
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
                       GenericDropdown(
                        label: '6.2 Water storage method',
                        initialValue: _waterStorageMethod,
                        isInvalid: _isInvalid['waterStorageMethod']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _waterStorageMethod = value;
                            _isInvalid['waterStorageMethod'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '6.3 Water dispensed through taps',
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
                        label: '6.4 Safety of water certified by analytical reports (Bacteriology - 01, Chemical - 01)',
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