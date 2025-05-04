import 'package:firebase_auth/firebase_auth.dart';

class OTPService {
  final _auth = FirebaseAuth.instance;
  String? _verificationId;
  int? _resendToken;

  Future<void> sendCode(
      String phone, {
        required void Function() onSent,
        required void Function(FirebaseAuthException e) onError,
      }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      forceResendingToken: _resendToken,
      verificationCompleted: (_) {},
      verificationFailed: onError,
      codeSent: (id, resend) {
        _verificationId = id;
        _resendToken    = resend;
        onSent();
      },
      codeAutoRetrievalTimeout: (id) => _verificationId = id,
    );
  }

  Future<bool> verifyCode(String smsCode) async {
    if (_verificationId == null) return false;
    try {
      final cred = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(cred);
      await _auth.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }
}
