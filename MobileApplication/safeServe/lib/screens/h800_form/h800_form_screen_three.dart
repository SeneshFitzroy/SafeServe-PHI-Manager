// lib/screens/h800_form/h800_form_screen_three.dart
import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'widgets/radio_button_field.dart';
import '../register_shop/screen_one/widgets/next_button.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';

class H800FormScreenThree extends StatefulWidget {
  final H800FormData formData;

  const H800FormScreenThree({super.key, required this.formData});

  @override
  State<H800FormScreenThree> createState() => _H800FormScreenThreeState();
}

class _H800FormScreenThreeState extends State<H800FormScreenThree> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // No validation needed since all fields are radio buttons with default values
  void onNextPressed() {
    // For now, we'll pop back as a placeholder since there's no Screen 4
    // You can update this to navigate to a submission screen or save the data
    Navigator.pop(context);
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

                // Progress Indicator (100% for Screen 3)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: 1.0, // Form is fully completed
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),

                // Part 10: Display of Health Instructions, Record Keeping & Certification
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Part 10 - Display of Health Instructions, Record Keeping & Certification',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // 10.1 Display of the instruction and health messages for the consumers/employees
                RadioButtonField(
                  label:
                      '10.1 Display of the instruction and health messages for the consumers/employees',
                  value: widget.formData.displayHealthInstructions,
                  onChanged: (val) => setState(() {
                    widget.formData.displayHealthInstructions = val;
                  }),
                ),

                // 10.2 Entertains consumer/employee complaints and suggestions
                RadioButtonField(
                  label:
                      '10.2 Entertains consumer/employee complaints and suggestions',
                  value: widget.formData.entertainsComplaints,
                  onChanged: (val) => setState(() {
                    widget.formData.entertainsComplaints = val;
                  }),
                ),

                // 10.3 Steps taken to prevent smoking within the premises
                RadioButtonField(
                  label:
                      '10.3 Steps taken to prevent smoking within the premises',
                  value: widget.formData.preventSmoking,
                  onChanged: (val) => setState(() {
                    widget.formData.preventSmoking = val;
                  }),
                ),

                // 10.4 Issuing of bills and record keeping when selling/purchasing food
                RadioButtonField(
                  label:
                      '10.4 Issuing of bills and record keeping when selling/purchasing food',
                  value: widget.formData.issuingBills,
                  onChanged: (val) => setState(() {
                    widget.formData.issuingBills = val;
                  }),
                ),

                // 10.5 Availability of accredited certification on food safety
                RadioButtonField(
                  label:
                      '10.5 Availability of accredited certification on food safety',
                  value: widget.formData.foodSafetyCertification,
                  onChanged: (val) => setState(() {
                    widget.formData.foodSafetyCertification = val;
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
                      onPressed: onNextPressed,
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
