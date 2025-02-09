import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ShopCard extends StatelessWidget {
  final String name;
  final String address;
  final String lastInspectionDate;
  final String grade;
  final String imagePath;
  final VoidCallback onDetailsTap;

  const ShopCard({
    Key? key,
    required this.name,
    required this.address,
    required this.lastInspectionDate,
    required this.grade,
    required this.imagePath,
    required this.onDetailsTap,
  }) : super(key: key);

  static const Map<String, Color> _gradeColors = {
    'A': Color(0xFF3DB952),
    'B': Color(0xFFF1D730),
    'C': Color(0xFFFF8514),
    'D': Color(0xFFBB1F22),
  };

  @override
  Widget build(BuildContext context) {
    final Color badgeColor = _gradeColors[grade] ?? Colors.grey;

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
          // We'll add margin around the image
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
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
                // Shop Name
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20, // updated to 20
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 35,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    grade,
                    style: const TextStyle(
                      fontSize: 25, // big grade text
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
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
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Last Inspection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Last Inspection Date : $lastInspectionDate',
                style: const TextStyle(
                  fontSize: 12, // updated to 12
                  color: Colors.black,
                ),
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
                  // Use the arrow icon from material_design_icons_flutter
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
