import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatingScoreScreen(),
    );
  }
}

class CalculatingScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade100, Colors.purple.shade100],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 4,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Calculating Score...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Please wait while we process the inspection data',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Custom Nav Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    CustomNavBarIcon(
                      icon: Icons.home,
                      label: 'Home',
                      route: '/home',
                      selected: false,
                    ),
                    CustomNavBarIcon(
                      icon: Icons.message,
                      label: 'Messages',
                      route: '/messages',
                      selected: false,
                    ),
                    CustomNavBarIcon(
                      icon: Icons.settings,
                      label: 'Settings',
                      route: '/settings',
                      selected: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Custom Navigation Icon Widget ---
class CustomNavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool selected;

  const CustomNavBarIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultIconColor = Colors.black;
    final Color selectedIconColor = const Color(0xFF1F41BB);

    return Tooltip(
      message: label,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          if (ModalRoute.of(context)?.settings.name != route) {
            Navigator.pushNamed(context, route);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFCDE6FE) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: selected ? selectedIconColor : defaultIconColor,
            size: 28,
          ),
        ),
      ),
    );
  }
}
