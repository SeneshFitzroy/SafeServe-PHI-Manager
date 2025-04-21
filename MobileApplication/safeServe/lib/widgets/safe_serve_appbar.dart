import 'package:flutter/material.dart';
import '../screens/Search_Page/Searchpage.dart';

class SafeServeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final VoidCallback onMenuPressed;

  const SafeServeAppBar({
    super.key,
    required this.height,
    required this.onMenuPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const SizedBox(width: 20),
          Image.asset('assets/images/other/logo.png', height: 40, width: 40),
          const SizedBox(width: 5),
          const Text(
            'SafeServe',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F41BB),
            ),
          ),
        ],
      ),
      actions: [
        // Search Icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: const Color(0xFFCDE6FE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.search_rounded, color: Color(0xFF4964C7), size: 22),
              onPressed: () {
                // Use the direct navigation with MaterialPageRoute instead of named route
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
            ),
          ),
        ),
        // Hamburger
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: const Color(0xFFCDE6FE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFF4964C7), size: 22),
              onPressed: onMenuPressed,
            ),
          ),
        ),
      ],
    );
  }
}
