/// NO real SMS: the owner must type 123456 – nothing else is accepted.
class OtpService {
  static const _fixedCode = '123456';

  /// “Send” code – we just return `true` after 500 ms so the UI can proceed.
  Future<bool> sendOtp(String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  /// Validate the code the PHI typed.
  Future<bool> verifyOtp({required String smsCode}) async =>
      smsCode == _fixedCode;
}
