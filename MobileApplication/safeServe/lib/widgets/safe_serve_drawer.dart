import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/profilepage/Profile.dart';
import '../services/auth_service.dart';
import '../services/logout_service.dart';

import '../screens/calendar/calendar_screen.dart';
import '../screens/map_view/map_view_screen.dart';
import '../screens/Reports_Analytics.dart/Reports.dart';
import '../screens/login_screen/login_screen.dart';

class SafeServeDrawer extends StatelessWidget {
  const SafeServeDrawer({super.key});

  Future<_DrawerProfile> _profile() async {
    final cached = await AuthService.instance.getCachedProfile();
    if (cached == null) return const _DrawerProfile.loading();
    final uid = cached['uid'] as String;
    final snap =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final d = snap.data() ?? {};
    return _DrawerProfile(
      uid:   uid,
      name:  d['full_name'] as String? ?? 'Unknown',
      role:  d['role']     as String? ?? 'PHI',
      image: d['profilePicture'] as String? ?? '',
    );
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width * .7,
    child: Drawer(
      child: FutureBuilder<_DrawerProfile>(
        future: _profile(),
        builder: (_, snap) {
          final p = snap.data ?? const _DrawerProfile.loading();
          return Column(
            children: [
              _Header(profile: p),
              Container(height: 2, color: const Color(0xFF1F41BB)),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _item(context, Icons.dashboard,   'Dashboard',       () {}),
                    _item(context, Icons.calendar_today,'Calendar',       () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const CalendarScreen()));
                    }),
                    _item(context, Icons.store,       'Shops',           () {}),
                    _item(context, Icons.description, 'Forms',           () {}),
                    _item(context, Icons.note,        'Notes',           () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/notes');
                    }),
                    _item(context, Icons.map,         'Map View',        () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const MapViewScreen()));
                    }),
                    _item(context, Icons.notifications,'Notifications',  () {}),
                    _item(context, Icons.assessment,  'Reports',         () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const Reports()));
                    }),
                    _item(context, Icons.settings,    'Settings',        () {}),
                    _item(context, Icons.help_outline,'Support',         () {}),
                    _item(context, Icons.logout,      'Logout',          () async {
                      await LogoutService.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (_) => false,
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  ListTile _item(BuildContext ctx, IconData ic, String lbl, VoidCallback tap) {
    return ListTile(
      leading: Icon(ic, color: Colors.black),
      title: Text(lbl, style: const TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.pop(ctx);
        tap();
      },
    );
  }
}

class _Header extends StatelessWidget {
  final _DrawerProfile profile;
  const _Header({required this.profile});

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
          backgroundImage:
          profile.image.isNotEmpty ? NetworkImage(profile.image) : null,
          child: profile.image.isEmpty
              ? const Icon(Icons.person, size: 40, color: Colors.black54)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              const SizedBox(height: 4),
              Text(profile.role,
                  style:
                  const TextStyle(fontSize: 14, color: Colors.black87)),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios,
              color: Color(0xFF1F41BB)),
          onPressed: profile.isLoading
              ? null
              : () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProfileScreen(uid: profile.uid,)),
            );
          },
        ),
      ],
    ),
  );
}

class _DrawerProfile {
  final String uid, name, role, image;
  final bool isLoading;
  const _DrawerProfile({
    required this.uid,
    required this.name,
    required this.role,
    required this.image,
    this.isLoading = false,
  });
  const _DrawerProfile.loading()
      : uid = '',
        name = 'Loading…',
        role = '',
        image = '',
        isLoading = true;
}
