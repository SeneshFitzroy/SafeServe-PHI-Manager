// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:safeserve/screens/map_view/map_view_screen.dart'; // Use only this import for map view
import 'package:safeserve/screens/reports_screen.dart';

import '../screens/calendar/calendar_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../services/logout_service.dart'; 

import '../screens/Reports_Analytics.dart/Reports.dart';
import '../screens/map_view/map_view_screen.dart';

class SafeServeDrawer extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String userPost;

  const SafeServeDrawer({
    super.key,
    required this.profileImageUrl,
    required this.userName,
    required this.userPost,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.7,
      child: Drawer(
        child: Column(
          children: [
            _buildProfileHeader(context),
            Container(height: 2, color: const Color(0xFF1F41BB)),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () {}),
                  _buildDrawerItem(
                    icon: Icons.calendar_today,
                    label: 'Calendar',
                    onTap: () {
                      Navigator.pop(context);              // close drawer
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const CalendarScreen()),
                      );
                    },
                  ),
                  _buildDrawerItem(icon: Icons.store, label: 'Shops', onTap: () {}),
                  _buildDrawerItem(icon: Icons.description, label: 'Forms', onTap: () {}),
                  _buildDrawerItem(
                    icon: Icons.map, 
                    label: 'Map View', 
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const MapViewScreen()),
                      );
                    }
                  ),
                  _buildDrawerItem(icon: Icons.notifications, label: 'Notifications', onTap: () {}),
                  _buildDrawerItem(
                    icon: Icons.assessment,
                    label: 'Reports',
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Reports()),
                      );
                    },
                  ),
                  _buildDrawerItem(icon: Icons.settings, label: 'Settings', onTap: () {}),
                  _buildDrawerItem(icon: Icons.help_outline, label: 'Support', onTap: () {}),
                  _buildDrawerItem(
                    icon: Icons.logout,
                    label: 'Logout',
                    onTap: () async {
                      await LogoutService.instance.signOut();

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            backgroundImage: (profileImageUrl.isNotEmpty) ? NetworkImage(profileImageUrl) : null,
            child: (profileImageUrl.isEmpty)
                ? const Icon(Icons.person, size: 40, color: Colors.black54)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  userPost,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1F41BB)),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
      onTap: onTap,
    );
  }
}
