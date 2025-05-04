import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../registered_shops/registered_shops_screen.dart';

class H800SuccessScreen extends StatelessWidget {
  const H800SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text('Inspection Submitted\nSuccessfully!',
                textAlign: TextAlign.center,
                style:
                TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff1F41BB))),
            const SizedBox(height: 40),
            Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                  color: Color(0xff3DB952), shape: BoxShape.circle),
              child: const Icon(Icons.check, size: 120, color: Colors.white),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                  'Your inspection report has been recorded. You can view it in past inspections',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16)),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color(0xff1F41BB)),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisteredShopsScreen()),
                          (r) => false),
                  child: const Text('Go to Dashboard',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }
}
