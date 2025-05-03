import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class _Keys {
  static const email       = 'ss_email';
  static const uid         = 'ss_uid';
  static const district    = 'ss_district';
  static const gnDivisions = 'ss_gn_divisions';
  static const lastOnline  = 'ss_last_online';
}

class AuthService {
  AuthService._();
  static final instance = AuthService._();

  final _auth  = FirebaseAuth.instance;
  final _db    = FirebaseFirestore.instance;
  final _store = const FlutterSecureStorage();
  final _dateFmt = DateFormat('yyyy-MM-dd');


  Future<String?> login({required String email, required String password}) async {
    final hasNet = await _hasInternet();
    return hasNet
        ? _loginOnline(email: email, password: password)
        : _loginOffline(email: email, password: password);
  }

  Future<Map<String, dynamic>?> getCachedProfile() async {
    final email = await _store.read(key: _Keys.email);
    final uid   = await _store.read(key: _Keys.uid);
    final district = await _store.read(key: _Keys.district);
    final gnStr    = await _store.read(key: _Keys.gnDivisions);

    if ([email, uid, district, gnStr].any((e) => e == null)) return null;

    return {
      'email'      : email,
      'uid'        : uid,
      'district'   : district,
      'gnDivisions': jsonDecode(gnStr!),
    };
  }

  Future<String?> _loginOnline({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      final snap = await _db.collection('users').doc(cred.user!.uid).get();
      final data = snap.data();
      if (data == null) {
        return 'Profile not found in DataBase.';
      }

      await _store.write(key: _Keys.email,       value: email.trim());
      await _store.write(key: _Keys.uid,         value: cred.user!.uid);
      await _store.write(key: _Keys.district,    value: data['district'] ?? '');
      await _store.write(
        key: _Keys.gnDivisions,
        value: jsonEncode(data['gnDivisions'] ?? []),
      );
      await _store.write(
        key: _Keys.lastOnline,
        value: _dateFmt.format(DateTime.now()),
      );

      return null; // success
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    } catch (_) {
      return 'Online login failed. Try again.';
    }
  }

  Future<String?> _loginOffline({
    required String email,
    required String password,
  }) async {
    // Universal offline password
    if (password != '101010') return 'Offline login failed.';

    final cachedEmail = await _store.read(key: _Keys.email);
    final lastOnline  = await _store.read(key: _Keys.lastOnline);
    final today       = _dateFmt.format(DateTime.now());

    if (cachedEmail == null || cachedEmail.trim() != email.trim()) {
      return 'Offline login failed.';
    }
    if (lastOnline != today) {
      return 'Daily online login required after 07:30.';
    }
    return null;
  }

  Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  String _mapError(String code) => switch (code) {
    'user-not-found'         => 'No user for that email.',
    'wrong-password'         => 'Incorrect password.',
    'invalid-email'          => 'Email malformed.',
    'network-request-failed' => 'Network error.',
    _                        => 'Auth error. ($code)',
  };
}