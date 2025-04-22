// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

/// A small wrapper around [FirebaseAuth] so UI code stays clean.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign‑in with e‑mail & password.
  /// Returns the logged‑in [User] on success. Throws a message string on error.
  Future<User> signIn({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      // Translate common error codes to readable text
      switch (e.code) {
        case 'invalid-email':
          throw 'E‑mail address is malformed.';
        case 'user-disabled':
          throw 'This user has been disabled.';
        case 'user-not-found':
          throw 'No user found for that e‑mail.';
        case 'wrong-password':
          throw 'Incorrect password.';
        default:
          throw e.message ?? 'Authentication error';
      }
    } catch (_) {
      throw 'Unexpected error – please try again.';
    }
  }

  /// Sign‑out
  Future<void> signOut() => _auth.signOut();

  /// Stream of auth changes (optional)
  Stream<User?> get userChanges => _auth.userChanges();
}
