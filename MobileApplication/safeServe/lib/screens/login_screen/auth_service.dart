// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

/// A simple wrapper around FirebaseAuth.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in with email & password.
  /// Throws [AuthException] on any error, with .message set to the real exception.
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) {
        throw const AuthException('no-user', 'No user returned');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      // Map known codes
      String msg;
      switch (e.code) {
        case 'invalid-email':
          msg = 'That email address is invalid.';
          break;
        case 'user-disabled':
          msg = 'This user has been disabled.';
          break;
        case 'user-not-found':
          msg = 'No user found for that email.';
          break;
        case 'wrong-password':
          msg = 'Wrong password provided.';
          break;
        default:
          msg = e.message ?? 'Authentication error, please try again.';
      }
      throw AuthException(e.code, msg);
    } catch (e, st) {
      // Log full exception & stack for debugging:
      // ignore: avoid_print
      print('AuthService.signIn error: $e\n$st');
      // surface the raw error to UI
      throw AuthException('unknown', e.toString());
    }
  }
}

/// Carries a FirebaseAuth error code & a user‑facing message.
class AuthException implements Exception {
  final String code;
  final String message;
  const AuthException(this.code, this.message);
  @override
  String toString() => 'AuthException($code): $message';
}
