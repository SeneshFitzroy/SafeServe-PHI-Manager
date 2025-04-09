import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ShopInfoCard extends StatelessWidget {
  final Map<String, dynamic> shopData;

  const ShopInfoCard({super.key, required this.shopData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row + icons (view, edit, delete)
            Row(
              children: [
                const Text(
                  'Shop Details',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Spacer(),
                _buildIconButton(
                  MdiIcons.eyeOutline,
                  const Color(0xFF34AC33),
                  context: context,
                  onTap: () {
                    // Navigate to the ViewShopDetailScreen and pass shopData
                    Navigator.pushNamed(
                      context,
                      '/view_shop_detail',
                      arguments: shopData,
                    );
                  },
                ), // View
                _buildIconButton(MdiIcons.pencilOutline, const Color(0xFFF1D730)),
                _buildIconButton(MdiIcons.trashCanOutline, const Color(0xFFBB1F22),
                    isDelete: true, context: context), // Delete
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Reference No', shopData['referenceNo']),
            _buildDetailRow('PHI Area', shopData['phiArea']),
            _buildDetailRow('Type of Trade', shopData['typeOfTrade']),
            _buildDetailRow('Address', shopData['address']),
            _buildDetailRow('Name of the Owner', shopData['ownerName']),
            _buildDetailRow('Telephone NO', shopData['telephone']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(fontSize: 18, color: Color(0xFF838383))),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon,
      Color borderColor, {
        bool isDelete = false,
        BuildContext? context,
        VoidCallback? onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          if (isDelete && context != null) {
            _showDeleteConfirmation(context);
          } else if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Icon(icon, color: borderColor, size: 22),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this shop?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF1F41BB),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                // perform delete operation
              },
              child: const Text('Yes'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1F41BB),
                side: const BorderSide(color: Color(0xFF1F41BB)),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
