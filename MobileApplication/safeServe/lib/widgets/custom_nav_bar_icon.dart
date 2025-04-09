import 'package:flutter/material.dart';
import '../screens/registered_shops/registered_shops_screen.dart';

/// Simple enum to identify which icon is which
enum NavItem {
  calendar,
  shops,
  dashboard,
  form,
  notifications,
}

class CustomNavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final NavItem navItem;
  final bool selected;

  const CustomNavBarIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.navItem,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color defaultIconColor = Colors.black;
    final Color selectedIconColor = const Color(0xFF1F41BB);

    return InkWell(
      onTap: () {
        switch (navItem) {
          case NavItem.calendar:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Calendar placeholder')),
            );
            break;
          case NavItem.shops:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RegisteredShopsScreen()),
            );
            break;
          case NavItem.dashboard:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dashboard placeholder')),
            );
            break;
          case NavItem.form:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Form placeholder')),
            );
            break;
          case NavItem.notifications:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications placeholder')),
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
