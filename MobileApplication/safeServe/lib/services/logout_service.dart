import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogoutService {
  LogoutService._();
  static final instance = LogoutService._();

  final _auth = FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();

  Future<void> signOut() async {
    // Firebase sign-out
    await _auth.signOut();

    await _storage.delete(key: 'ss_email');
    await _storage.delete(key: 'ss_uid');
    await _storage.delete(key: 'ss_district');
    await _storage.delete(key: 'ss_gn_divisions');
    await _storage.delete(key: 'ss_last_online');
  }
}