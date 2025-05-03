import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Keeps a simple in‑memory list of Firestore `add` operations.
/// Deleted if the app is killed, as requested.
class OfflineQueue {
  OfflineQueue._() {
    _sub = Connectivity()
        .onConnectivityChanged
        .listen((r) { if (r != ConnectivityResult.none) flush(); });
  }
  static final instance = OfflineQueue._();
  late final StreamSubscription _sub;

  final _db = FirebaseFirestore.instance;
  final List<_Write> _writes = [];

  void addCreate({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) {
    _writes.add(_Write(collectionPath, data));
  }

  Future<void> flush() async {
    if (_writes.isEmpty) return;
    final pending = List<_Write>.from(_writes);
    _writes.clear();
    for (final w in pending) {
      try {
        await _db.collection(w.collection).add(w.data);
      } catch (_) {
        // If it still fails, push back and break
        _writes.addAll(pending);
        break;
      }
    }
  }

  void dispose() => _sub.cancel();
}

class _Write {
  final String collection;
  final Map<String, dynamic> data;
  _Write(this.collection, this.data);
}
