// lib/screens/notes/note_edit_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';

class NoteEditScreen extends StatefulWidget {
  final String? noteId; // null = new note
  const NoteEditScreen({Key? key, this.noteId}) : super(key: key);

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _titleCtrl   = TextEditingController();
  final _contentCtrl = TextEditingController();
  late final DocumentReference _doc;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    _doc = FirebaseFirestore.instance
        .collection('notes')
        .doc(
      widget.noteId
          ?? FirebaseFirestore.instance.collection('notes').doc().id,
    );
    _load();
  }

  Future<void> _load() async {
    if (widget.noteId == null) {
      setState(() => _loaded = true);
      return;
    }
    final snap = await _doc.get();
    if (snap.exists) {
      final d = snap.data()! as Map<String, dynamic>;
      _titleCtrl.text   = d['title']   ?? '';
      _contentCtrl.text = d['content'] ?? '';
    }
    setState(() => _loaded = true);
  }

  Future<void> _save() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _doc.set({
      'title': _titleCtrl.text.trim().isEmpty
          ? 'Text Note'
          : _titleCtrl.text.trim(),
      'content': _contentCtrl.text,
      'lastModified': FieldValue.serverTimestamp(),
      'userId': FirebaseFirestore.instance.doc('/users/$uid'),
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        await _save();
        return true;
      },
      child: Scaffold(
        appBar: SafeServeAppBar(
          height: 70,
          onMenuPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
        endDrawer: const SafeServeDrawer(),
        body: Stack(
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
                ),
              ),
            ),

            // Content
            Column(
              children: [
                // Back + title row
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await _save();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCDE6FE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF1F41BB),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _titleCtrl,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black12,
                ),

                // Content editor
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _contentCtrl,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText: 'Write something…',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }
}
