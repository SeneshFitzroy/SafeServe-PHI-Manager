import 'package:flutter/material.dart';

class SafeServeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final VoidCallback onMenuPressed; // We trigger the endDrawer

  const SafeServeAppBar({
    Key? key,
    required this.height,
    required this.onMenuPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      backgroundColor: Colors.white,
      titleSpacing: 0,
      automaticallyImplyLeading: false, // no default leading
      title: Row(
        children: [
          const SizedBox(width: 20),
          // Logo
          Image.asset(
            'assets/images/other/logo.png',
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 5),
          // SafeServe text
          const Text(
            'SafeServe',
            style: TextStyle(
              fontSize: 25, // per your request
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F41BB),
            ),
          ),
        ],
      ),
      actions: [
        // Search Icon (Smaller Background)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Container(
            width: 37, // Reduced size
            height: 37, // Reduced size
            decoration: BoxDecoration(
              color: const Color(0xFFCDE6FE),
              borderRadius: BorderRadius.circular(8), // Smaller corner radius
            ),
            child: IconButton(
              icon: const Icon(Icons.search_rounded, color: Color(0xFF4964C7), size: 22), // Smaller icon
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
          ),
        ),
        // Hamburger Menu Icon (Smaller Background)
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            width: 37, // Reduced size
            height: 37, // Reduced size
            decoration: BoxDecoration(
              color: const Color(0xFFCDE6FE),
              borderRadius: BorderRadius.circular(8), // Smaller corner radius
            ),
            child: IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFF4964C7), size: 22, weight: 800), // Smaller icon
              onPressed: onMenuPressed, // Calls the callback to open the drawer
            ),
          ),
        ),
      ],
    );
  }
}
