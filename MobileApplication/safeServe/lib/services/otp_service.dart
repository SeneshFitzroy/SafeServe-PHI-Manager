class OtpService {
  static const _fixedCode = '123456';

  Future<bool> sendOtp(String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<bool> verifyOtp({required String smsCode}) async =>
      smsCode == _fixedCode;
}
