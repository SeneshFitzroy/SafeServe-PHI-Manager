import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';
import 'widgets/generic_dropdown.dart';
import 'widgets/radio_button_field.dart';

class H800FormScreenSeven extends StatefulWidget {
  final H800FormData formData;
  final String shopId;
  final String phiId;

  const H800FormScreenSeven({
    super.key,
    required this.formData,
    required this.shopId,
    required this.phiId,
  });

  @override
  H800FormScreenSevenState createState() => H800FormScreenSevenState();
}

class H800FormScreenSevenState extends State<H800FormScreenSeven> {
  // Part 7: Waste Management
  String? _numberofBinswithLids;
  String? _lidsOfBinsClosed;
  String? _cleanlinessOfWasteBins;
  String? _seperationofWaste;
  String? _disposalOfWaste;
  String? _managementofWasteWater;
  String? _adequateNumberOfToilets;
  String? _locationOfToilets;
  String? _cleanlinessOfToilets;
  String? _septicTankCondition;

  // Validation flags
  Map<String, bool> _isInvalid = {};

  @override
  void initState() {
    super.initState();
    // Initialize values from formData
    _numberofBinswithLids = widget.formData.numberofBinswithLids;
    _lidsOfBinsClosed = widget.formData.lidsOfBinsClosed;
    _cleanlinessOfWasteBins = widget.formData.cleanlinessOfWasteBins;
    _seperationofWaste = widget.formData.seperationofWaste;
    _disposalOfWaste = widget.formData.disposalOfWaste;
    _managementofWasteWater = widget.formData.managementofWasteWater;
    _adequateNumberOfToilets = widget.formData.adequateNumberOfToilets;
    _locationOfToilets = widget.formData.locationOfToilets;
    _cleanlinessOfToilets = widget.formData.cleanlinessOfToilets;
    _septicTankCondition = widget.formData.septicTankCondition;

    // Initialize validation flags
    _isInvalid = {
      'numberofBinswithLids': false,
      'lidsOfBinsClosed': false,
      'cleanlinessOfWasteBins': false,
      'seperationofWaste': false,
      'disposalOfWaste': false,
      'managementofWasteWater': false,
      'adequateNumberOfToilets': false,
      'locationOfToilets': false,
      'cleanlinessOfToilets': false,
      'septicTankCondition': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['numberofBinswithLids'] = _numberofBinswithLids == null;
      _isInvalid['lidsOfBinsClosed'] = _lidsOfBinsClosed == null;
      _isInvalid['cleanlinessOfWasteBins'] = _cleanlinessOfWasteBins == null;
      _isInvalid['seperationofWaste'] = _seperationofWaste == null;
      _isInvalid['disposalOfWaste'] = _disposalOfWaste == null;
      _isInvalid['managementofWasteWater'] = _managementofWasteWater == null;
      _isInvalid['adequateNumberOfToilets'] = _adequateNumberOfToilets == null;
      _isInvalid['locationOfToilets'] = _locationOfToilets == null;
      _isInvalid['cleanlinessOfToilets'] = _cleanlinessOfToilets == null;
      _isInvalid['septicTankCondition'] = _septicTankCondition == null;
    });

    isValid = !_isInvalid.containsValue(true);
    return isValid;
  }

  void _updateFormData() {
    widget.formData.numberofBinswithLids = _numberofBinswithLids;
    widget.formData.lidsOfBinsClosed = _lidsOfBinsClosed;
    widget.formData.cleanlinessOfWasteBins = _cleanlinessOfWasteBins;
    widget.formData.seperationofWaste = _seperationofWaste;
    widget.formData.disposalOfWaste = _disposalOfWaste;
    widget.formData.managementofWasteWater = _managementofWasteWater;
    widget.formData.adequateNumberOfToilets = _adequateNumberOfToilets;
    widget.formData.locationOfToilets = _locationOfToilets;
    widget.formData.cleanlinessOfToilets = _cleanlinessOfToilets;
    widget.formData.septicTankCondition = _septicTankCondition;
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
                    value: 0.7, // 7/10 of the form completed
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
                        'Part 7: Waste Management (10 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '7.1 Adequate number of bins with lids',
                        initialValue: _numberofBinswithLids,
                        isInvalid: _isInvalid['numberofBinswithLids']!,
                        items: const ['Available', 'Unavailable'],
                        onChanged: (value) {
                          setState(() {
                            _numberofBinswithLids = value;
                            _isInvalid['numberofBinswithLids'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '7.2 Lids of bins closed',
                        value: _lidsOfBinsClosed,
                        isInvalid: _isInvalid['lidsOfBinsClosed']!,
                        onChanged: (value) {
                          setState(() {
                            _lidsOfBinsClosed = value;
                            _isInvalid['lidsOfBinsClosed'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '7.3 Cleanliness & maintenance of waste bins',
                        initialValue: _cleanlinessOfWasteBins,
                        isInvalid: _isInvalid['cleanlinessOfWasteBins']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _cleanlinessOfWasteBins = value;
                            _isInvalid['cleanlinessOfWasteBins'] =
                                value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '7.4 Separation/Segregation of waste',
                        value: _seperationofWaste,
                        isInvalid: _isInvalid['seperationofWaste']!,
                        onChanged: (value) {
                          setState(() {
                            _seperationofWaste = value;
                            _isInvalid['seperationofWaste'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '7.5 Final disposal of waste',
                        initialValue: _disposalOfWaste,
                        isInvalid: _isInvalid['disposalOfWaste']!,
                        items: const ['Safe', 'Unsafe'],
                        onChanged: (value) {
                          setState(() {
                            _disposalOfWaste = value;
                            _isInvalid['disposalOfWaste'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '7.6 Management of waste water',
                        initialValue: _managementofWasteWater,
                        isInvalid: _isInvalid['managementofWasteWater']!,
                        items: const ['Safe', 'Unsafe'],
                        onChanged: (value) {
                          setState(() {
                            _managementofWasteWater = value;
                            _isInvalid['managementofWasteWater'] =
                                value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '7.7 Adequate number of toilets & urinals',
                        value: _adequateNumberOfToilets,
                        isInvalid: _isInvalid['adequateNumberOfToilets']!,
                        onChanged: (value) {
                          setState(() {
                            _adequateNumberOfToilets = value;
                            _isInvalid['adequateNumberOfToilets'] =
                                value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '7.8 Location of toilets & urinals',
                        initialValue: _locationOfToilets,
                        isInvalid: _isInvalid['locationOfToilets']!,
                        items: const ['Safe', 'Unsafe'],
                        onChanged: (value) {
                          setState(() {
                            _locationOfToilets = value;
                            _isInvalid['locationOfToilets'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '7.9 Cleanliness of toilets & urinals',
                        initialValue: _cleanlinessOfToilets,
                        isInvalid: _isInvalid['cleanlinessOfToilets']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _cleanlinessOfToilets = value;
                            _isInvalid['cleanlinessOfToilets'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '7.10 Septic tank condition',
                        initialValue: _septicTankCondition,
                        isInvalid: _isInvalid['septicTankCondition']!,
                        items: const ['Safe', 'Unsafe'],
                        onChanged: (value) {
                          setState(() {
                            _septicTankCondition = value;
                            _isInvalid['septicTankCondition'] = value == null;
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
                                  '/h800_form_screen_eight',
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
