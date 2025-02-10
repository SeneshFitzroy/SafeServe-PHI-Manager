import 'package:flutter/material.dart';
import '../../../../widgets/grade_badge.dart';

class ShopDetailHeader extends StatelessWidget {
  final String shopName;
  final String grade;

  const ShopDetailHeader({
    super.key,
    required this.shopName,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFCDE6FE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1F41BB)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              shopName,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          GradeBadge(grade: grade, size: 40, fontSize: 25),
        ],
      ),
    );
  }
}
