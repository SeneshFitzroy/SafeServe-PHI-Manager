// lib/screens/notes/notes_list_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // for ScrollDirection

import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';
import '../../../widgets/custom_nav_bar_icon.dart';
import '../../../widgets/custom_nav_bar_icon.dart' show NavItem;
import 'note_editor_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({Key? key}) : super(key: key);

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final _auth   = FirebaseAuth.instance;
  final _scroll = ScrollController();
  bool  _navVisible   = true;
  final Set<String> _selectedIds = {};

  late final Query<Map<String, dynamic>> _ref;

  @override
  void initState() {
    super.initState();

    final uid = _auth.currentUser!.uid;
    _ref = FirebaseFirestore.instance
        .collection('notes')
        .where(
      'userId',
      isEqualTo: FirebaseFirestore.instance.doc('users/$uid'),
    )
        .withConverter<Map<String, dynamic>>(
      fromFirestore: (snap, _) => snap.data()!,
      toFirestore: (m, _) => m,
    );

    _scroll.addListener(() {
      final dir = _scroll.position.userScrollDirection;
      if (dir == ScrollDirection.reverse && _navVisible) {
        setState(() => _navVisible = false);
      } else if (dir == ScrollDirection.forward && !_navVisible) {
        setState(() => _navVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(() {})
      ..dispose();
    super.dispose();
  }

  Future<void> _deleteSelected() async {
    final count = _selectedIds.length;
    if (count == 0) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete $count note${count>1?'s':''}?'),
        content: Text('Are you sure you want to delete '
            '${count>1?'these notes':'this note'}?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF1F41BB),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Yes', style: TextStyle(color: Colors.white)),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      final batch = FirebaseFirestore.instance.batch();
      for (var id in _selectedIds) {
        batch.delete(FirebaseFirestore.instance.collection('notes').doc(id));
      }
      await batch.commit();
      setState(() => _selectedIds.clear());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$count note${count>1?'s':''} deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSel = _selectedIds.isNotEmpty;

    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () => Scaffold.of(context).openEndDrawer(),
      ),
      endDrawer: const SafeServeDrawer(
        profileImageUrl: '',
        userName: 'My Notes',
        userPost: '',
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
            ),
          ),
        ),

        Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 16, 25, 8),
            child: Row(children: [
              InkWell(
                onTap: () {
                  if (isSel) {
                    setState(() => _selectedIds.clear());
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCDE6FE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    isSel ? Icons.close : Icons.arrow_back_rounded,
                    color: const Color(0xFF1F41BB),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isSel ? '${_selectedIds.length} selected' : 'All notes',
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ]),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _ref.snapshots(),
              builder: (_, snap) {
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snap.data!.docs;
                if (docs.isEmpty) {
                  return const Center(child: Text('No notes yet'));
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GridView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.only(bottom: 90),
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 120,
                      mainAxisExtent:    160,
                      crossAxisSpacing:  15,
                      mainAxisSpacing:   15,
                    ),
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final doc  = docs[i];
                      final data = doc.data();
                      final ts   = data['lastModified'] as Timestamp?;
                      final dt   = ts?.toDate();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _noteCard(
                              id: doc.id,
                              content: data['content'] ?? '',
                              isSelected: _selectedIds.contains(doc.id),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data['title'] ?? 'Text Note',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dt == null
                                ? ''
                                : '${dt.year}/${_two(dt.month)}/${_two(dt.day)}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ]),

        _bottomNav(context),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isSel ? Colors.red : Colors.grey[300],
        onPressed: () {
          if (isSel) {
            _deleteSelected();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NoteEditScreen()),
            );
          }
        },
        child: Icon(isSel ? Icons.delete : Icons.edit,
            color: isSel ? Colors.white : Colors.black),
      ),
    );
  }

  /// _noteCard now fills its entire allotted slot with a fixed-shape background:
  Widget _noteCard({
    required String id,
    required String content,
    bool isSelected = false,
  }) {
    final preview = content.length > 100
        ? '${content.substring(0, 100)}…'
        : content;

    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (_selectedIds.contains(id)) {
            _selectedIds.remove(id);
          } else {
            _selectedIds.add(id);
          }
        });
      },
      onTap: () {
        if (_selectedIds.isNotEmpty) {
          setState(() {
            if (_selectedIds.contains(id)) {
              _selectedIds.remove(id);
            } else {
              _selectedIds.add(id);
            }
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NoteEditScreen(noteId: id)),
          );
        }
      },
      child: Stack(children: [
        // Fill the whole card area with a fixed white box:
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              preview,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ),
        if (isSelected)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        if (isSelected)
          const Positioned(
            top: 8,
            right: 8,
            child: Icon(Icons.check_circle, color: Colors.white, size: 24),
          ),
      ]),
    );
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  Widget _bottomNav(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width * 0.8;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      bottom: _navVisible ? 30 : -100,
      left: (MediaQuery.of(ctx).size.width - w) / 2,
      width: w,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6)
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNavBarIcon(
                icon: Icons.event,
                label: 'Calendar',
                navItem: NavItem.calendar),
            CustomNavBarIcon(
                icon: Icons.store,
                label: 'Shops',
                navItem: NavItem.shops),
            CustomNavBarIcon(
                icon: Icons.dashboard,
                label: 'Dashboard',
                navItem: NavItem.dashboard),
            CustomNavBarIcon(
                icon: Icons.description,
                label: 'Form',
                navItem: NavItem.form),
            CustomNavBarIcon(
              icon: Icons.notifications,
              label: 'Notifications',
              navItem: NavItem.notifications,
            ),
          ],
        ),
      ),
    );
  }
}
