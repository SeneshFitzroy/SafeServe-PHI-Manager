import 'package:flutter/material.dart';
import '../screens/Search_Page/Searchpage.dart';

class SafeServeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Function()? onMenuPressed;

  const SafeServeAppBar({
    Key? key,
    required this.height,
    this.onMenuPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(
            'assets/images/other/logo.png',
            height: 30,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.shield, color: Color(0xFF4964C7), size: 30),
          ),
          const SizedBox(width: 8),
          const Text(
            'SafeServe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4964C7),
            ),
          ),
        ],
      ),
      actions: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFCDE6FE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF4964C7)),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
        ),
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFCDE6FE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF4964C7)),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ],
    );
  }
}
