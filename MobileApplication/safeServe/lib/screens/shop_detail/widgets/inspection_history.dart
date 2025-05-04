import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InspectionHistory extends StatelessWidget {
  final List<Timestamp> inspectionTimestamps;
  const InspectionHistory({super.key, required this.inspectionTimestamps});

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:
        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Inspection History',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: inspectionTimestamps.length,
            itemBuilder: (_, i) {
              final d = inspectionTimestamps[i].toDate();
              final dateStr = DateFormat('yyyy-MM-dd').format(d);
              return _card(dateStr);
            },
          )
        ]),
      ),
    );
  }

  Widget _card(String date) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF4289FC)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(date,
        style: const TextStyle(fontSize: 18, color: Colors.black)),
  );
}
