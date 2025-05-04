import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safeserve/screens/h800_form/widgets/h800_form_button.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../services/otp_service.dart';
import '../../services/inspection_uploader.dart';
import 'submit_success_screen.dart';
import 'h800_form_data.dart';

class OwnerOtpScreen extends StatefulWidget {
  final String shopId;
  final String phiId;
  final H800FormData form;
  final List<File> photos;
  final GeoPoint? firstLocation;

  const OwnerOtpScreen(
      {super.key,
        required this.shopId,
        required this.phiId,
        required this.form,
        required this.photos,
        required this.firstLocation});

  @override
  State<OwnerOtpScreen> createState() => _OwnerOtpScreenState();
}

class _OwnerOtpScreenState extends State<OwnerOtpScreen> {
  final _otpSvc   = OTPService();
  final _codeCtrl = TextEditingController();
  int _seconds    = 120;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _send(); _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _seconds = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds == 0) return _timer!.cancel();
      setState(() => _seconds -= 1);
    });
  }

  Future<void> _send() async {
    final snap = await FirebaseFirestore.instance
        .collection('shops')
        .doc(widget.shopId)
        .get();
    final phone = (snap['telephone'] as String).trim();   // 07XXXXXXXX

    await _otpSvc.sendCode(
      phone,
      onSent : () => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('OTP sent'))),
      onError: (e) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? e.code))),
    );
  }

  Future<void> _verify() async {
    final ok = await _otpSvc.verifyCode(_codeCtrl.text.trim());
    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid code')));
      return;
    }

    // -------- verified → upload everything ----------
    await InspectionUploader.upload(
      form          : widget.form,
      shopId        : widget.shopId,
      phiId         : widget.phiId,
      firstImageLocation: widget.firstLocation,
      images        : widget.photos,
    );

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SubmitSuccessScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: SafeServeAppBar(height: 70,
      onMenuPressed: () => Scaffold.of(context).openEndDrawer(),
    ),
    body: Stack(
      children: [
        _bg(),
        Column(
          children: [
            const SizedBox(height: 40),
            const Text('Verify by Owner',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F41BB))),
            const SizedBox(height: 15),
            const Text('Enter the OTP sent to Owner’s Phone',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
            PinBoxes(controller: _codeCtrl),
            const SizedBox(height: 40),
            H800FormButton(label: 'Verify', onPressed: _verify),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Didn’t get code?  '),
                InkWell(
                  onTap: _seconds == 0 ? () { _send(); _startTimer(); } : null,
                  child: const Text('Resend',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFF1F41BB))),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Expire in $_seconds sec',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    ),
  );

  Widget _bg() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
      ),
    ),
  );

  @override
  void dispose() {
    _timer?.cancel();
    _codeCtrl.dispose();
    super.dispose();
  }
}

//≈≈≈≈ Small 6‑box input ≈≈≈≈
class PinBoxes extends StatelessWidget {
  final TextEditingController controller;
  const PinBoxes({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: TextField(
        controller: controller,
        maxLength: 6,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 24, letterSpacing: 18),
        decoration: const InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1F41BB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1F41BB), width: 2),
          ),
        ),
      ),
    );
  }
}
