import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../screens/h800_form/h800_form_data.dart';

class InspectionUploader {
  static Future<void> upload({
    required H800FormData form,
    required String shopId,
    required String phiId,
    required List<File> images,
    GeoPoint? firstImageLocation,
  }) async {
    final fs  = FirebaseFirestore.instance;
    final now = Timestamp.now();

    // 1) Upload images
    final urls = <String>[];
    for (int i = 0; i < images.length; i++) {
      final id   = const Uuid().v4();
      final path = 'h800_images/$shopId/$id.jpg';
      final ref  = FirebaseStorage.instance.ref(path);
      await ref.putFile(images[i]);
      urls.add(await ref.getDownloadURL());
    }

    // 2) Write form doc (one collection per shop)
    final formMap           = form.toMap();
    formMap['shopId']       = fs.doc('shops/$shopId');
    formMap['phiId']        = fs.doc('users/$phiId');
    formMap['submittedAt']  = now;
    formMap['imageUrls']    = urls;
    formMap['imageLocation'] = firstImageLocation;

    final formsCol = fs.collection('h800_forms');
    await formsCol.add(formMap);

    // 3) Update shops/{shopId}
    final score = form.calculateTotalScore();
    final pct   = (score / 100);
    String grade;
    int days;
    if (pct >= .75)       { grade = 'A'; days = 90; }
    else if (pct >= .50)  { grade = 'B'; days = 60; }
    else if (pct >= .25)  { grade = 'C'; days = 30; }
    else                  { grade = 'D'; days = 30; }

    final shopRef = fs.collection('shops').doc(shopId);
    await shopRef.update({
      'grade'          : grade,
      'lastInspection' : FieldValue.arrayUnion([now]),
      'upcomingInspection':
      Timestamp.fromDate(DateTime.now().add(Duration(days: days))),
    });
  }
}
