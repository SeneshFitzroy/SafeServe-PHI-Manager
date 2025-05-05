import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../services/auth_service.dart';        // cached UID
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/safe_serve_drawer.dart';    // your common AppBar

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required String uid}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic>? data;    // Firestore user doc
  bool loading = true;

  /*──────── initial load ────────*/
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() => loading = true);
    try {
      final cached = await AuthService.instance.getCachedProfile();
      final uid = cached?['uid'] as String? ?? '';
      if (uid.isEmpty) throw 'No uid';

      final snap =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      data = snap.data()!..['uid'] = uid;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Load error: $e')));
    } finally {
      setState(() => loading = false);
    }
  }

  /*──────── avatar flow ────────*/
  Future<void> _changeAvatar() async {
    // permission
    if (!await Permission.photos.request().isGranted &&
        !await Permission.storage.request().isGranted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Permission denied')));
      return;
    }

    // pick
    final XFile? x = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 512, imageQuality: 85);
    if (x == null) return;

    // optimistic preview
    setState(() => data!['profilePicture'] = x.path);

    try {
      final uid = data!['uid'];
      final ref =
      FirebaseStorage.instance.ref('profile_pictures/$uid.jpg');
      await ref.putFile(File(x.path),
          SettableMetadata(contentType: 'image/jpeg'));
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'profilePicture': url}, SetOptions(merge: true));

      await _fetch(); // refresh with canonical URL
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Photo updated')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      await _fetch(); // roll back optimistic preview
    }
  }

  /*──────── read‑only field helper ────────*/
  Widget _ro(String label, String v) => Padding(
    padding: const EdgeInsets.only(top: 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      const SizedBox(height: 8),
      Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF4289FC)),
        ),
        child: Text(v.isEmpty ? '—' : v,
            style: const TextStyle(fontSize: 18)),
      ),
    ]),
  );

  /*──────── UI ────────*/
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (data == null) {
      return const Scaffold(body: Center(child: Text('Profile not found')));
    }

    final gn = List<String>.from(data!['gnDivisions'] ?? []);

    return Scaffold(
      key: _scaffoldKey, // attach the key here
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: const SafeServeDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF1F41BB)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 24),

            /*──────── avatar ────────*/
            Center(
              child: GestureDetector(
                onTap: _changeAvatar,
                child: Stack(children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF1F41BB), width: 2)),
                    child: ClipOval(
                      child: () {
                        final pic = data!['profilePicture'] ?? '';
                        if (pic is String && pic.startsWith('http')) {
                          return Image.network(pic,
                              width: 150, height: 150, fit: BoxFit.cover);
                        } else if (pic is String && File(pic).existsSync()) {
                          return Image.file(File(pic),
                              width: 150, height: 150, fit: BoxFit.cover);
                        }
                        return const Icon(Icons.person,
                            size: 80, color: Color(0xFF1F41BB));
                      }(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF1F41BB),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2)),
                      child: const Icon(Icons.camera_alt,
                          size: 20, color: Colors.white),
                    ),
                  )
                ]),
              ),
            ),

            /*──────── read‑only details ────────*/
            _ro('PHI ID',             data!['phiId'] ?? ''),
            _ro('Full Name',          data!['full_name'] ?? ''),
            _ro('NIC',                data!['nic'] ?? ''),
            _ro('Phone',              data!['phone'] ?? ''),
            _ro('Email',              data!['email'] ?? ''),
            _ro('Personal Address',   data!['personalAddress'] ?? ''),
            _ro('District',           data!['district'] ?? ''),

            const SizedBox(height: 20),
            const Text('GN Divisions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Wrap(
                spacing: 10,
                runSpacing: 10,
                children: gn
                    .map((d) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFF4289FC))),
                    child: Text(d,
                        style: const TextStyle(fontSize: 16))))
                    .toList()),

            const SizedBox(height: 30),

          ]),
        ),
      ),
    );
  }
}
