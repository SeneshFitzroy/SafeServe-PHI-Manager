import 'package:flutter/material.dart';
import '../../../../widgets/grade_badge.dart';

class InspectionHistory extends StatelessWidget {
  final List<dynamic> inspectionData;

  const InspectionHistory({super.key, required this.inspectionData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inspection History',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),

            Column(
              children: inspectionData.map((history) {
                final date = history['date'] as String? ?? '';
                final grade = history['grade'] as String? ?? 'A';
                return _buildHistoryRow(date, grade);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryRow(String date, String grade) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(date, style: const TextStyle(fontSize: 18, color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: GradeBadge(grade: grade, size: 35, fontSize: 20),
          ),
          Expanded(
             flex: 2,
             child: Align(
               alignment: Alignment.centerRight,
               child: InkWell(
                 onTap: () {},
                 child: Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(6),
                     border: Border.all(color: Color(0xFF1F41BB)),
                   ),
                   child: const Text(
                     'View',
                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1F41BB)),
                  ),
                 ),
               ),
             ),
           ),
        ],
      ),
    );
  }
}
