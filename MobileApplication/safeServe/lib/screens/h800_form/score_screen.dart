// lib/screens/h800_form/score_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/safe_serve_appbar.dart';
import 'h800_form_data.dart';
import 'owner_otp_screen.dart';
import 'package:geolocator/geolocator.dart';

class H800ScoreScreen extends StatelessWidget {
  final H800FormData formData;
  final String shopId, phiId;
  final List<File> photos;
  final Position position;

  const H800ScoreScreen(
      {super.key,
        required this.formData,
        required this.shopId,
        required this.phiId,
        required this.photos,
        required this.position});

  @override
  Widget build(BuildContext context) {
    final total = formData.calculateTotalScore();
    final percent = (total / 100 * 100).round();
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
      appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffE6F5FE), Color(0xffF5ECF9)]),
        ),
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text('Inspection Score',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1F41BB))),
            const SizedBox(height: 40),
            Text('Score $percent%',
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            _buildStar(grade),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color(0xff1F41BB)),
                onPressed: () => _verifyByOwner(context),
                child: const Text('Verify by Owner',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStar(String grade) => Container(
    width: 180,
    height: 180,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xffF1D730),
    ),
    child: Text(grade,
        style: const TextStyle(
            fontSize: 90, fontWeight: FontWeight.bold, color: Colors.white)),
  );

  Future<void> _verifyByOwner(BuildContext ctx) async {
    final snap =
    await FirebaseFirestore.instance.collection('shops').doc(shopId).get();
    final phone = snap.data()?['telephone'] as String?;
    if (phone == null) {
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Owner phone not found')));
      return;
    }

    Navigator.pushReplacement(
      ctx,
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
  }
}
