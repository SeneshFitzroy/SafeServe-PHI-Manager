import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import '../../screens/h800_form/h800_form_data.dart';

class InspectionSubmissionService {
  final _fs      = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _uuid    = const Uuid();

  /// Saves HC‑800 form + photos, updates grade / last‑ & next‑inspection.
  Future<void> submit({
    required H800FormData   data,
    required List<File>     images,
    required Position       position,
    required String         shopId,
    required String         phiId,
  }) async {
    // ───────── 1. upload pictures ───────────────────────────────────────
    final meta = SettableMetadata(contentType: 'image/jpeg');
    final urls = <String>[];

    for (final file in images) {
      final name = '${DateTime.now().millisecondsSinceEpoch}_${_uuid.v4()}.jpg';
      final ref  = _storage.ref('h800/$shopId/$name');
      await ref.putFile(file, meta);
      urls.add(await ref.getDownloadURL());
    }

    // ───────── 2. build Firestore payload ───────────────────────────────
    final shopRef = _fs.collection('shops').doc(shopId);
    final phiRef  = _fs.collection('users').doc(phiId);

    final total   = data.calculateTotalScore();
    final grade   = _gradeFromScore(total);
    final now     = Timestamp.now();

    await _fs.collection('h800_forms').add({
      ...data.toJson(),                                   // every answer
      'totalScore'     : total,
      'grade'          : grade,
      'shopId'         : shopRef,                         // 🔗 reference
      'phiId'          : phiRef,                          // 🔗 reference
      'photoUrls'      : urls,
      'submittedAt'    : now,
      'location'       : GeoPoint(position.latitude, position.longitude),
    });

    // ───────── 3. update shop doc ───────────────────────────────────────
    final next = Timestamp.fromDate(
      now.toDate().add(_durationForGrade(grade)),
    );

    await shopRef.set({
      'grade'             : grade,
      'lastInspection'    : FieldValue.arrayUnion([now]),
      'upcomingInspection': next,
    }, SetOptions(merge: true));
  }

  // helpers
  String _gradeFromScore(int s) {
    if (s >= 75) return 'A';
    if (s >= 60) return 'B';
    if (s >= 45) return 'C';
    return 'D';
  }

  Duration _durationForGrade(String g) =>
      g == 'A' ? const Duration(days: 90)
          : g == 'B' ? const Duration(days: 60)
          : const Duration(days: 30);
}
