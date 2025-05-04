import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../h800_form/widgets/h800_form_button.dart';
import '../h800_form/h800_form_data.dart';
import 'owner_otp_screen.dart';

class ScoreScreen extends StatelessWidget {
  final H800FormData form;
  final String shopId;
  final String phiId;
  final List<File> photos;
  final GeoPoint? firstLocation;

  const ScoreScreen({
    super.key,
    required this.form,
    required this.shopId,
    required this.phiId,
    required this.photos,
    required this.firstLocation,
  });

  @override
  Widget build(BuildContext context) {
    final score   = form.calculateTotalScore();
    final percent = score.toString();                 // already 0‑100 int
    final grade   = _gradeOf(score);

    return Scaffold(
      appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
      body: Stack(
        children: [
          _bg(),
          Column(
            children: [
              const SizedBox(height: 40),
              const Text('Inspection Score',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F41BB))),
              const SizedBox(height: 30),
              Text('Score $percent%',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              SizedBox(
                height: 180,
                width: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.star_rounded,
                        size: 180, color: Colors.amber[600]),
                    Text(grade,
                        style: const TextStyle(
                            fontSize: 80, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              H800FormButton(
                label: 'Verify by Owner',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OwnerOtpScreen(
                      shopId        : shopId,
                      phiId         : phiId,
                      form          : form,
                      photos        : photos,
                      firstLocation : firstLocation,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _gradeOf(int score) {
    if (score >= 75) return 'A';
    if (score >= 50) return 'B';
    if (score >= 25) return 'C';
    return 'D';
  }

  Widget _bg() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
      ),
    ),
  );
}
