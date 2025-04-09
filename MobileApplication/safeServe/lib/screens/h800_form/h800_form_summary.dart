import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';

class H800FormSummary extends StatelessWidget {
  final H800FormData formData;

  const H800FormSummary({super.key, required this.formData});

  // Total possible score
  static const int totalPossibleScore = 100; 

  // Method to determine the grade based on percentage
  String getGrade(double percentage) {
    if (percentage >= 75 && percentage <= 100) {
      return 'A Grade (Good)';
    } else if (percentage >= 50 && percentage < 75) {
      return 'B Grade (Satisfactory)';
    } else if (percentage >= 25 && percentage < 50) {
      return 'C Grade (Unsatisfactory)';
    } else {
      return 'D Grade (Very Unsatisfactory)';
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalScore = formData.calculateTotalScore();
    final percentage = (totalScore / totalPossibleScore) * 100; 
    final grade = getGrade(percentage);

    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {},
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                RegisterShopHeader(
                  title: 'H800 Form Summary',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Form Submission Summary',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'Total Score: $totalScore / $totalPossibleScore',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Percentage: ${percentage.toStringAsFixed(2)}%',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.blue),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Grade: $grade',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _getGradeColor(grade),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      H800FormButton(
                        label: 'Finish',
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/registered_shops_screen',
                            (route) => false,
                          );
                        },
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

  // Helper method to get color based on grade
  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) {
      return Colors.green;
    } else if (grade.startsWith('B')) {
      return Colors.blue;
    } else if (grade.startsWith('C')) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
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