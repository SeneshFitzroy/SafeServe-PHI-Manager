import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:geolocator/geolocator.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../services/otp_service.dart';
import '../../services/inspection_submission_service.dart';
import 'h800_form_data.dart';
import 'success_screen.dart';

class OwnerOtpScreen extends StatefulWidget {
  final String       phone;
  final H800FormData formData;
  final List<File>   photos;
  final Position     position;
  final String       shopId, phiId;

  const OwnerOtpScreen({
    super.key,
    required this.phone,
    required this.formData,
    required this.photos,
    required this.position,
    required this.shopId,
    required this.phiId,
  });

  @override
  State<OwnerOtpScreen> createState() => _OwnerOtpScreenState();
}

class _OwnerOtpScreenState extends State<OwnerOtpScreen> {
  final _otpSvc    = OtpService();
  final _submitSvc = InspectionSubmissionService();

  String _code = '';
  bool   _sent = false;
  bool   _busy = false;

  @override
  void initState() {
    super.initState();
    _sendFakeCode();
  }

  Future<void> _sendFakeCode() async {
    final ok = await _otpSvc.sendOtp(widget.phone);
    if (mounted) setState(() => _sent = ok);
  }

  Future<void> _verify() async {
    if (!_sent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Code not sent yet – please wait')),
      );
      return;
    }
    if (_busy) return;

    setState(() => _busy = true);
    final valid = await _otpSvc.verifyOtp(smsCode: _code);
    if (!valid) {
      setState(() => _busy = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid code')));
      return;
    }

    // persist inspection
    await _submitSvc.submit(
      data     : widget.formData.copyWith(shopId: widget.shopId, phiId: widget.phiId),
      images   : widget.photos,
      position : widget.position,
      shopId   : widget.shopId,
      phiId    : widget.phiId,
    );

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const H800SuccessScreen()),
            (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffE6F5FE), Color(0xffF5ECF9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        child: LayoutBuilder(builder: (ctx, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 100,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Text(
                      'Verify by Owner',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1F41BB),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter the OTP sent to ${widget.phone}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        onChanged: (_) {},
                        onCompleted: (v) => _code = v,
                        pinTheme: PinTheme(
                          inactiveColor: const Color(0xff1F41BB),
                          selectedColor: const Color(0xff1F41BB),
                          activeColor: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1F41BB),
                        minimumSize: const Size(180, 45),
                      ),
                      onPressed: _busy ? null : _verify,
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _sent ? null : _sendFakeCode,
                      child: const Text('Didn’t get code?  Retry'),
                    ),
                    const Spacer(), // pushes content up when empties
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
