import 'package:flutter/material.dart';

class FormSelectionScreen extends StatelessWidget {
  final Map<String, dynamic> formData;

  const FormSelectionScreen({Key? key, required this.formData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Selection'),
        backgroundColor: const Color(0xFF1F41BB),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Forms',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F41BB),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildFormCard(context, 'Food Establishment Inspection', 'Inspect food handling and safety'),
                    _buildFormCard(context, 'Health Compliance Check', 'Verify health standards compliance'),
                    _buildFormCard(context, 'Sanitation Report', 'Evaluate sanitation conditions'),
                    _buildFormCard(context, 'Disease Prevention Audit', 'Check disease prevention measures'),
                    _buildFormCard(context, 'Public Health Risk Assessment', 'Assess public health risks'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context, String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Handle form selection
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: $title')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F41BB),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF1F41BB),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
