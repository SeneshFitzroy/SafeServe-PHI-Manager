import 'package:flutter/material.dart';

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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
