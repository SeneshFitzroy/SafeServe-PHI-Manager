import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return switch (e.code) {
        'user-not-found'         => 'No user found for that email.',
        'wrong-password'         => 'Incorrect password.',
        'invalid-credential'     => 'Email or password is invalid.',
        'network-request-failed' => 'Network error. Check your connection.',
        _                        => 'Authentication failed. (${e.code})',
      };
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }
}