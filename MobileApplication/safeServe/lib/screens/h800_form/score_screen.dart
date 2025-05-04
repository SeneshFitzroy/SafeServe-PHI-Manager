import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../../widgets/safe_serve_appbar.dart';
import 'h800_form_data.dart';
import 'owner_otp_screen.dart';

class H800ScoreScreen extends StatelessWidget {
  final H800FormData formData;
  final String shopId, phiId;
  final List<File> photos;
  final Position position;

  const H800ScoreScreen({
    super.key,
    required this.formData,
    required this.shopId,
    required this.phiId,
    required this.photos,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final total = formData.calculateTotalScore();
    final percent = (total).round();
    late String grade;
    if (total >= 75) {
      grade = 'A';
    } else if (total >= 50) {
      grade = 'B';
    } else if (total >= 25) {
      grade = 'C';
    } else {
      grade = 'D';
    }

    return Scaffold(
      // SafeServeAppBar
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {},
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70),

            // Title
            const Text(
              'Inspection Score',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F41BB),
              ),
            ),

            const SizedBox(height: 40),

            // Score %
            Text(
              'Score $percent%',
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            // Star badge (you can swap to a custom star shape if desired)
            Container(
              width: 180,
              height: 180,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFF1D730),
                shape: BoxShape.circle,
              ),
              child: Text(
                grade,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const Spacer(),

            // Verify by Owner button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: ElevatedButton(
                onPressed: () async {
                  final snap = await FirebaseFirestore.instance
                      .collection('shops')
                      .doc(shopId)
                      .get();
                  final phone = snap.data()?['telephone'] as String?;
                  if (phone == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Owner phone not found')),
                    );
                    return;
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OwnerOtpScreen(
                        phone: phone,
                        formData: formData,
                        photos: photos,
                        position: position,
                        shopId: shopId,
                        phiId: phiId,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF1F41BB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Verify by Owner',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
