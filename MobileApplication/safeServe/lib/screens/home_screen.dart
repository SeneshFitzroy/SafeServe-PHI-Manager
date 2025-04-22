import 'package:flutter/material.dart';
import 'package:safeserve/widgets/safe_serve_appbar.dart';
import 'package:safeserve/widgets/custom_nav_bar_icon.dart';
import 'package:safeserve/widgets/safe_serve_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 60,
        onMenuPressed: () {
          // Handle menu press
        },
      ),
      body: Center(
        child: Text('Home Screen Content'),
      ),
      bottomNavigationBar: SafeServeBottomNav(currentRoute: '/home'),
    );
  }
}

SafeServeBottomNav({required String currentRoute}) {
}