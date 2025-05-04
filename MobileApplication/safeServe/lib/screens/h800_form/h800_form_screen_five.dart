import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenFive extends StatefulWidget {
  final H800FormData formData;
  final String shopId;
  final String phiId;

  const H800FormScreenFive({
    super.key,
    required this.formData,
    required this.shopId,
    required this.phiId,
  });

  @override
  H800FormScreenFiveState createState() => H800FormScreenFiveState();
}

class H800FormScreenFiveState extends State<H800FormScreenFive> {
  // Part 5: Storage
  String? _storageFacilities;
  String? _storageOfRawMaterials;
  String? _storageOfCookedFood;
  String? _foodStoredTemp;
  String? _storageInRefrigerator;
  String? _measuresToPreventContamination;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _storageFacilities = widget.formData.storageFacilities;
    _storageOfRawMaterials = widget.formData.storageOfRawMaterials;
    _storageOfCookedFood = widget.formData.storageOfCookedFood;
    _foodStoredTemp = widget.formData.foodStoredTemp;
    _storageInRefrigerator = widget.formData.storageInRefrigerator;
    _measuresToPreventContamination =
        widget.formData.measuresToPreventContamination;

    // Initialize validation flags
    _isInvalid = {
      'storageFacilities': false,
      'storageOfRawMaterials': false,
      'storageOfCookedFood': false,
      'foodStoredTemp': false,
      'storageInRefrigerator': false,
      'measuresToPreventContamination': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['storageFacilities'] = _storageFacilities == null;
      _isInvalid['storageOfRawMaterials'] = _storageOfRawMaterials == null;
      _isInvalid['storageOfCookedFood'] = _storageOfCookedFood == null;
      _isInvalid['foodStoredTemp'] = _foodStoredTemp == null;
      _isInvalid['storageInRefrigerator'] = _storageInRefrigerator == null;
      _isInvalid['measuresToPreventContamination'] =
          _measuresToPreventContamination == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.storageFacilities = _storageFacilities;
    widget.formData.storageOfRawMaterials = _storageOfRawMaterials;
    widget.formData.storageOfCookedFood = _storageOfCookedFood;
    widget.formData.foodStoredTemp = _foodStoredTemp;
    widget.formData.storageInRefrigerator = _storageInRefrigerator;
    widget.formData.measuresToPreventContamination =
        _measuresToPreventContamination;
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
                    value: 0.5, // 5/10 of the form completed
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
                        'Part 5: Storage (10 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                        label:
                        '5.3 Storage of cooked/partially cooked/prepared food',
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
                      RadioButtonField(
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
                        label:
                        '5.5 Storage of food in refrigerator/deep freezer',
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
                        label:
                        '5.6 Measures taken to prevent contamination during food storage',
                        initialValue: _measuresToPreventContamination,
                        isInvalid:
                        _isInvalid['measuresToPreventContamination']!,
                        items: const ['Good', 'Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _measuresToPreventContamination = value;
                            _isInvalid['measuresToPreventContamination'] =
                                value == null;
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
                                  '/h800_form_screen_six',
                                  arguments: {
                                    'formData': widget.formData,
                                    'shopId': widget.shopId,
                                    'phiId': widget.phiId,
                                  },
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
