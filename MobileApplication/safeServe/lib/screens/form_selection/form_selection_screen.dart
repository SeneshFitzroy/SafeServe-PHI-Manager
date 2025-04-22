import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/custom_nav_bar_icon.dart';

class FormSelectionScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const FormSelectionScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fix the error by returning a widget
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 100,
        onMenuPressed: () {
          Navigator.pushNamed(context, '/menu');
        },
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
              child: Text(
                'Form Selection',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Form selection buttons would go here
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to a specific form
                        Navigator.pushNamed(context, '/h800_form_screen');
                      },
                      child: Text('H800 Form'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Select a form to begin',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Add bottom navigation bar for consistency
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 38, left: 35, right: 35),
        height: 98,
        child: Container(
          width: 318,
          height: 60,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomNavBarIcon(
                icon: Icons.home_outlined,
                label: 'Home',
                route: '/',
                selected: false,
              ),
              CustomNavBarIcon(
                icon: Icons.calendar_today_outlined,
                label: 'Calendar',
                route: '/calendar',
                selected: false,
              ),
              CustomNavBarIcon(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                route: '/notifications',
                selected: false,
              ),
              CustomNavBarIcon(
                icon: Icons.person_outline,
                label: 'Profile',
                route: '/profile',
                selected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}