import 'package:flutter/material.dart';
import '../screens/Reports_Analytics.dart/Reports.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/registered_shops/registered_shops_screen.dart';
import '../screens/map_view/map_view_screen.dart';

/// Simple enum to identify which icon is which
enum NavItem {
  calendar,
  shops,
  dashboard,
  map,
  Report,
}

class CustomNavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final NavItem navItem;
  final bool selected;

  const CustomNavBarIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.navItem,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultIconColor = Colors.black;
    final Color selectedIconColor = const Color(0xFF1F41BB);

    return InkWell(
      onTap: () {
        switch (navItem) {
          case NavItem.calendar:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CalendarScreen()),
            );
            break;
          case NavItem.shops:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RegisteredShopsScreen()),
            );
            break;
          case NavItem.dashboard:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) =>  DashboardScreen()),
            );
            break;
          case NavItem.map:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MapViewScreen()),
            );
            break;
          case NavItem.Report:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Reports()),
            );
            break;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFCDE6FE) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: selected ? selectedIconColor : defaultIconColor,
          size: 30,
        ),
      ),
    );
  }
}
