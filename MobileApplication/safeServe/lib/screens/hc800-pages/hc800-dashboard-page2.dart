import 'package:flutter/material.dart';

class Hc800DashboardPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HC 800 Dashboard - Page 2'),
        backgroundColor: const Color(0xFF1F41BB),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Part 3 - Area of Food Preparation/Serving/Display/Storage',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F41BB),
            ),
          ),
          const SizedBox(height: 16),
          _buildChecklistItem('3.1 General cleanliness'),
          _buildChecklistItem('3.2 Safety measures for cleanliness'),
          _buildChecklistItem('3.3 Flies'),
          _buildChecklistItem('3.4 Ants/Cockroaches/Rodents and other disease carriers'),
          _buildChecklistItem('3.5 Maintenance of floor'),
          _buildChecklistItem('3.6 Maintenance of walls'),
          _buildChecklistItem('3.7 Maintenance of ceiling'),
          _buildChecklistItem('3.8 Space in the working area'),
          _buildChecklistItem('3.9 Daily cleaning'),
          _buildChecklistItem('3.10 Risk of contamination from toilets'),
          _buildChecklistItem('3.11 Adequate number of bins with lids for waste disposal'),
          _buildChecklistItem('3.12 Empty boxes/Gunny bags and other unnecessary items'),
          _buildChecklistItem('3.13 Availability of cleaning tools/materials/serviettes etc'),
          _buildChecklistItem('3.14 Objectionable odor'),
          _buildChecklistItem('3.15 Open drains and stagnated waste water'),
          _buildChecklistItem('3.16 Area used for sleeping or any other unrelated activities'),
          _buildChecklistItem('3.17 Use of separate chopping boards/knives etc.'),
          _buildChecklistItem('3.18 Cleanliness of equipment/utensils'),
          _buildChecklistItem('3.19 Suitability of the layout of the area for the processes'),
          _buildChecklistItem('3.20 Light and ventilation'),
          _buildChecklistItem('3.21 House Keeping'),
          _buildChecklistItem('3.22 Water supplied for different tasks in a suitable manner'),
          _buildChecklistItem('3.23 Safe food handling practices'),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle previous button action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF1F41BB), width: 2),
                ),
                child: const Text(
                  'Previous',
                  style: TextStyle(color: Color(0xFF1F41BB)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle next button action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF1F41BB), width: 2),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Color(0xFF1F41BB)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF3CB851)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
