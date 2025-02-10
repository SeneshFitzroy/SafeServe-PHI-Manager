import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../widgets/grade_badge.dart';

class ShopCard extends StatelessWidget {
  final String name;
  final String address;
  final String lastInspectionDate;
  final String grade;
  final String imagePath;
  final VoidCallback onDetailsTap;

  const ShopCard({
    super.key,
    required this.name,
    required this.address,
    required this.lastInspectionDate,
    required this.grade,
    required this.imagePath,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              imagePath,
              height: 131,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Title Row + Grade Badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                GradeBadge(grade: grade, size: 40, fontSize: 25),
              ],
            ),
          ),

          // Address
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                address,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),

          // Last Inspection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Last Inspection Date : $lastInspectionDate',
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),

          // Detail Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: onDetailsTap,
                child: Container(
                  margin: const EdgeInsets.only(right: 16, bottom: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F41BB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    MdiIcons.arrowRightCircleOutline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
