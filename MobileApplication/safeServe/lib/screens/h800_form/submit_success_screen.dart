import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../registered_shops/registered_shops_screen.dart';

class SubmitSuccessScreen extends StatelessWidget {
  const SubmitSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
    body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Inspection Submitted Successfully!',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F41BB))),
              const SizedBox(height: 35),
              Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                    color: Color(0xFF3DB952), shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 90),
              ),
              const SizedBox(height: 35),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Your inspection report has been recorded.\nYou can view it in past inspections.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 35),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const RegisteredShopsScreen()),
                      (_) => false,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F41BB),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 12),
                ),
                child: const Text('Go to Dashboard',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
