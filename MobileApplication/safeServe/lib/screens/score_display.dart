import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InspectionScoreScreen(),
    );
  }
}

class InspectionScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade100, Colors.purple.shade100],
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Inspection Score',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Score 75%',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipPath(
                              clipper: StarClipper(8, 0.5),
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.amber.shade300,
                                      Color(0xfff9e84b)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              'A',
                              style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black45,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            print("Finalizing and Submitting...");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'Finalize and Submit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: CustomNavBar(selectedIndex: 1),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Star Shape Clipper with Bigger Edges
class StarClipper extends CustomClipper<Path> {
  final int points;
  final double innerRatio;

  StarClipper(this.points, this.innerRatio);

  @override
  Path getClip(Size size) {
    Path path = Path();
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;
    double innerRadius = radius * innerRatio;
    double angle = pi / points;

    for (int i = 0; i < points * 2; i++) {
      double r = i.isEven ? radius : innerRadius;
      double x = centerX + r * cos(i * angle);
      double y = centerY + r * sin(i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// Custom NavBar
class CustomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 4, offset: Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomNavBarIcon(
              icon: Icons.home,
              label: "Home",
              route: "/",
              selected: selectedIndex == 0),
          CustomNavBarIcon(
              icon: Icons.analytics,
              label: "Score",
              route: "/",
              selected: selectedIndex == 1),
          CustomNavBarIcon(
              icon: Icons.settings,
              label: "Settings",
              route: "/",
              selected: selectedIndex == 2),
        ],
      ),
    );
  }
}

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

    return InkWell(
      onTap: () {
        if (route.isNotEmpty && route != '/') {
          Navigator.pushNamed(context, route);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(8),
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
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selected ? selectedIconColor : defaultIconColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
