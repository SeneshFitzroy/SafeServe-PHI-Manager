import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShopCreationJob {
  final String docId;
  final Map<String, dynamic> data;
  final String imagePath;

  ShopCreationJob(this.docId, this.data, this.imagePath);
}

class OfflineQueue {
  OfflineQueue._() {
    _sub = Connectivity()
        .onConnectivityChanged
        .listen((r) { if (r != ConnectivityResult.none) flush(); });
  }
  static final instance = OfflineQueue._();
  late final StreamSubscription _sub;

  final _db  = FirebaseFirestore.instance;
  final _fs  = FirebaseStorage.instance;
  final List<ShopCreationJob> _jobs = [];

  void addShopJob(ShopCreationJob job) => _jobs.add(job);

  Future<void> flush() async {
    if (_jobs.isEmpty) return;
    final pending = List<ShopCreationJob>.from(_jobs);
    _jobs.clear();

    for (final job in pending) {
      try {
        final snap = await _fs
            .ref('shops_images/${job.docId}.jpg')
            .putFile(File(job.imagePath),
            SettableMetadata(contentType: 'image/jpeg'));
        final url = await snap.ref.getDownloadURL();
        await _db.collection('shops').doc(job.docId).set({
          ...job.data,
          'image': url,
        });
      } catch (_) {
        _jobs.addAll(pending);
        break;
      }
    }
  }

  void dispose() => _sub.cancel();
}