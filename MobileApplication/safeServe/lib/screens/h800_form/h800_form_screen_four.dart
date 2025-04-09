import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'h800_form_summary.dart'; // Import the H800FormSummary widget
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

  // Part 8: Condition, Standard & Cleanliness of Food
  String? _conditionOfFood;
  String? _displayPackaging;
  String? _insectInfested;
  String? _violationOfLabeling;
  String? _separationOfUnwholesomeFood;

  // Part 9: Health Status and Training of Food Handlers
  String? _personalHygiene;
  String? _wearingProtectiveClothing;
  String? _communicableDiseases;
  String? _goodHealthHabits;
  String? _healthRecords;
  String? _trainingRecords;

  // Part 10: Display of Health Instructions, Record Keeping & Certification
  String? _displayHealthInstructions;
  String? _entertainsComplaints;
  String? _preventSmoking;
  String? _issuingBills;
  String? _foodSafetyCertification;

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

    _conditionOfFood = widget.formData.conditionOfFood;
    _displayPackaging = widget.formData.displayPackaging;
    _insectInfested = widget.formData.insectInfested;
    _violationOfLabeling = widget.formData.violationOfLabeling;
    _separationOfUnwholesomeFood = widget.formData.separationOfUnwholesomeFood;

    _personalHygiene = widget.formData.personalHygiene;
    _wearingProtectiveClothing = widget.formData.wearingProtectiveClothing;
    _communicableDiseases = widget.formData.communicableDiseases;
    _goodHealthHabits = widget.formData.goodHealthHabits;
    _healthRecords = widget.formData.healthRecords;
    _trainingRecords = widget.formData.trainingRecords;

    _displayHealthInstructions = widget.formData.displayHealthInstructions;
    _entertainsComplaints = widget.formData.entertainsComplaints;
    _preventSmoking = widget.formData.preventSmoking;
    _issuingBills = widget.formData.issuingBills;
    _foodSafetyCertification = widget.formData.foodSafetyCertification;

    // Initialize validation flags
    _isInvalid = {
      'numberofBinswithLids': false,
      'lidsOfBinsClosed': false,
      'cleanlinessOfWasteBins': false,
      'seperationofWaste':false,
      'disposalOfWaste': false,
      'managementofWasteWater':false,
      'adequateNumberOfToilets': false,
      'locationOfToilets': false,
      'cleanlinessOfToilets': false,
      'septicTankCondition': false,
      'conditionOfFood': false,
      'displayPackaging': false,
      'insectInfested': false,
      'violationOfLabeling': false,
      'separationOfUnwholesomeFood': false,
      'personalHygiene':false,//9.1
      'wearingProtectiveClothing': false,
      'communicableDiseases': false,
      'goodHealthHabits': false,
      'healthRecords': false,
      'trainingRecords': false,
      'displayHealthInstructions': false,
      'entertainsComplaints': false,
      'preventSmoking': false,
      'issuingBills': false,
      'foodSafetyCertification': false,
    };
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _isInvalid['numberofBinswithLids'] = _numberofBinswithLids == null;
      _isInvalid['lidsOfBinsClosed'] = _lidsOfBinsClosed == null;
      _isInvalid['cleanlinessOfWasteBins'] = _cleanlinessOfWasteBins == null;
      _isInvalid['seperationofWaste']=_seperationofWaste ==null;
      _isInvalid['disposalOfWaste'] = _disposalOfWaste == null;
      _isInvalid['managementofWasteWater'] =_managementofWasteWater ==null;
      _isInvalid['adequateNumberOfToilets'] = _adequateNumberOfToilets == null;
      _isInvalid['locationOfToilets'] = _locationOfToilets == null;
      _isInvalid['cleanlinessOfToilets'] = _cleanlinessOfToilets == null;
      _isInvalid['septicTankCondition'] = _septicTankCondition == null;
      _isInvalid['conditionOfFood'] = _conditionOfFood == null;
      _isInvalid['displayPackaging'] = _displayPackaging == null;
      _isInvalid['insectInfested'] = _insectInfested == null;
      _isInvalid['violationOfLabeling'] = _violationOfLabeling == null;
      _isInvalid['separationOfUnwholesomeFood'] =
          _separationOfUnwholesomeFood == null;
      _isInvalid['personalHygiene']=_personalHygiene ==null;    
      _isInvalid['wearingProtectiveClothing'] =
          _wearingProtectiveClothing == null;
      _isInvalid['communicableDiseases'] = _communicableDiseases == null;
      _isInvalid['goodHealthHabits'] = _goodHealthHabits == null;
      _isInvalid['healthRecords'] = _healthRecords == null;
      _isInvalid['trainingRecords'] = _trainingRecords == null;
      _isInvalid['displayHealthInstructions'] =
          _displayHealthInstructions == null;
      _isInvalid['entertainsComplaints'] = _entertainsComplaints == null;
      _isInvalid['preventSmoking'] = _preventSmoking == null;
      _isInvalid['issuingBills'] = _issuingBills == null;
      _isInvalid['foodSafetyCertification'] = _foodSafetyCertification == null;
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
    widget.formData.managementofWasteWater=_managementofWasteWater;
    widget.formData.adequateNumberOfToilets = _adequateNumberOfToilets;
    widget.formData.locationOfToilets = _locationOfToilets;
    widget.formData.cleanlinessOfToilets = _cleanlinessOfToilets;
    widget.formData.septicTankCondition = _septicTankCondition;

    widget.formData.conditionOfFood = _conditionOfFood;
    widget.formData.displayPackaging = _displayPackaging;
    widget.formData.insectInfested = _insectInfested;
    widget.formData.violationOfLabeling = _violationOfLabeling;
    widget.formData.separationOfUnwholesomeFood = _separationOfUnwholesomeFood;

    widget.formData.personalHygiene = _personalHygiene;
    widget.formData.wearingProtectiveClothing = _wearingProtectiveClothing;
    widget.formData.communicableDiseases = _communicableDiseases;
    widget.formData.goodHealthHabits = _goodHealthHabits;
    widget.formData.healthRecords = _healthRecords;
    widget.formData.trainingRecords = _trainingRecords;

    widget.formData.displayHealthInstructions = _displayHealthInstructions;
    widget.formData.entertainsComplaints = _entertainsComplaints;
    widget.formData.preventSmoking = _preventSmoking;
    widget.formData.issuingBills = _issuingBills;
    widget.formData.foodSafetyCertification = _foodSafetyCertification;
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
            padding: const EdgeInsets.only(top: 60), // Fixed 'custom' typo
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
                    value: 1.0, // 4/4 of the form completed
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
                        label: '7.4 Separation/Segregation of waster',
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
                            _isInvalid['managementofWasteWater'] = value == null;
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
                            _isInvalid['adequateNumberOfToilets'] = value == null;
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
                      const Text(
                        'Part 8: Condition, Standard & Cleanliness of Food (5 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '8.1 Condition of food/Raw materials',
                        initialValue: _conditionOfFood,
                        isInvalid: _isInvalid['conditionOfFood']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _conditionOfFood = value;
                            _isInvalid['conditionOfFood'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '8.2 Display/Packaging for sale/delivery ',
                        initialValue: _displayPackaging,
                        isInvalid: _isInvalid['displayPackaging']!,
                        items: const ['Satisfactory', 'Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _displayPackaging = value;
                            _isInvalid['displayPackaging'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '8.3 Insect infested/Out dated food & food unit for human consumption',
                        value: _insectInfested,
                        isInvalid: _isInvalid['insectInfested']!,
                        onChanged: (value) {
                          setState(() {
                            _insectInfested = value;
                            _isInvalid['insectInfested'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '8.4 Violation of labeling regulations',
                        value: _violationOfLabeling,
                        isInvalid: _isInvalid['violationOfLabeling']!,
                        onChanged: (value) {
                          setState(() {
                            _violationOfLabeling = value;
                            _isInvalid['violationOfLabeling'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '8.5 Separation/Storage of food that are unwholesome/outdated to be returned',
                        value: _separationOfUnwholesomeFood,
                        isInvalid: _isInvalid['separationOfUnwholesomeFood']!,
                        onChanged: (value) {
                          setState(() {
                            _separationOfUnwholesomeFood = value;
                            _isInvalid['separationOfUnwholesomeFood'] =
                                value == null;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Part 9: Health Status and Training of Food Handlers (10 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      GenericDropdown(
                        label: '9.1 Personal hygiene',
                        initialValue: _personalHygiene,
                        isInvalid: _isInvalid['personalHygiene']!,
                        items: const ['Good', 'Satisfactory','Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _personalHygiene = value;
                            _isInvalid['personalHygiene'] =
                                value == null;
                          });
                        },
                      ), 
                      GenericDropdown(
                        label: '9.2 Wearing of protective clothing',
                        initialValue: _wearingProtectiveClothing,
                        isInvalid: _isInvalid['wearingProtectiveClothing']!,
                        items: const ['Good', 'Satisfactory','Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _wearingProtectiveClothing = value;
                            _isInvalid['wearingProtectiveClothing'] =
                                value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '9.3 Communicable diseases/skin diseases',
                        value: _communicableDiseases,
                        isInvalid: _isInvalid['communicableDiseases']!,
                        onChanged: (value) {
                          setState(() {
                            _communicableDiseases = value;
                            _isInvalid['communicableDiseases'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '9.4 Good health habits',
                        initialValue: _goodHealthHabits,
                        isInvalid: _isInvalid['goodHealthHabits']!,
                        items: const ['Practiced', 'Not Practiced'],
                        onChanged: (value) {
                          setState(() {
                            _goodHealthHabits = value;
                            _isInvalid['goodHealthHabits'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '9.5 Maintenance of health records of employees',
                        initialValue: _healthRecords,
                        isInvalid: _isInvalid['healthRecords']!,
                        items: const ['Good', 'Satisfactory','Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _healthRecords = value;
                            _isInvalid['healthRecords'] = value == null;
                          });
                        },
                      ),
                      GenericDropdown(
                        label: '9.6 Maintenance of records regarding training on health employees',
                        initialValue: _trainingRecords,
                        isInvalid: _isInvalid['trainingRecords']!,
                        items: const ['Good', 'Satisfactory','Unsatisfactory'],
                        onChanged: (value) {
                          setState(() {
                            _trainingRecords = value;
                            _isInvalid['trainingRecords'] = value == null;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Part 10: Display of Health Instructions, Record Keeping & Certification (5 Marks)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      RadioButtonField(
                        label: '10.1 Display of instructions and health messages for the consumers/employees',
                        value: _displayHealthInstructions,
                        isInvalid: _isInvalid['displayHealthInstructions']!,
                        onChanged: (value) {
                          setState(() {
                            _displayHealthInstructions = value;
                            _isInvalid['displayHealthInstructions'] =
                                value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '10.2 Entertains consumer/employee complaints and suggestions',
                        value: _entertainsComplaints,
                        isInvalid: _isInvalid['entertainsComplaints']!,
                        onChanged: (value) {
                          setState(() {
                            _entertainsComplaints = value;
                            _isInvalid['entertainsComplaints'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '10.3 Steps taken to prevent smoking within the premises',
                        value: _preventSmoking,
                        isInvalid: _isInvalid['preventSmoking']!,
                        onChanged: (value) {
                          setState(() {
                            _preventSmoking = value;
                            _isInvalid['preventSmoking'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '10.4 Issuing of bills & record keeping when selling/purchasing food',
                        value: _issuingBills,
                        isInvalid: _isInvalid['issuingBills']!,
                        onChanged: (value) {
                          setState(() {
                            _issuingBills = value;
                            _isInvalid['issuingBills'] = value == null;
                          });
                        },
                      ),
                      RadioButtonField(
                        label: '10.5 Availability of accredited certification on food safety',
                        value: _foodSafetyCertification,
                        isInvalid: _isInvalid['foodSafetyCertification']!,
                        onChanged: (value) {
                          setState(() {
                            _foodSafetyCertification = value;
                            _isInvalid['foodSafetyCertification'] =
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
                            label: 'Submit',
                            onPressed: () {
                              if (_validateForm()) {
                                _updateFormData();
                                // Navigate to H800FormSummary page with updated formData
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => H800FormSummary(
                                      formData: widget.formData,
                                    ),
                                  ),
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
