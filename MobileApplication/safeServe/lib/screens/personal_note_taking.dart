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
            // Already on notes screen
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
              icon: const Icon(Icons.search_rounded,
                  color: Color(0xFF4964C7), size: 22),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
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
              icon: const Icon(Icons.menu_rounded,
                  color: Color(0xFF4964C7), size: 22),
              onPressed: onMenuPressed,
            ),
          ),
        ),
      ],
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, String>> _notes = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Current selected nav item
  NavItem _currentNavItem = NavItem.form;

  void _addNote() {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      setState(() {
        _notes.add({
          'title': _titleController.text,
          'content': _contentController.text,
        });
        _titleController.clear();
        _contentController.clear();
      });
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _onMenuPressed() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF3EAFD),
      appBar: SafeServeAppBar(
        height: 60,
        onMenuPressed: _onMenuPressed,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1F41BB),
              ),
              child: Text(
                'SafeServe Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Notes'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Added this container with constraints to prevent overflow
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Note Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _contentController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Note Content',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _addNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F41BB),
                    ),
                    icon: const Icon(Icons.note_add, color: Colors.white),
                    label: const Text('Add Note',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFFE6F5FE),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        _notes[index]['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_notes[index]['content'] ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNote(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomNavBarIcon(
              icon: Icons.calendar_today,
              label: 'Calendar',
              navItem: NavItem.calendar,
              selected: _currentNavItem == NavItem.calendar,
            ),
            CustomNavBarIcon(
              icon: Icons.store,
              label: 'Shops',
              navItem: NavItem.shops,
              selected: _currentNavItem == NavItem.shops,
            ),
            CustomNavBarIcon(
              icon: Icons.dashboard,
              label: 'Dashboard',
              navItem: NavItem.dashboard,
              selected: _currentNavItem == NavItem.dashboard,
            ),
            CustomNavBarIcon(
              icon: Icons.note_alt,
              label: 'Notes',
              navItem: NavItem.form,
              selected: _currentNavItem == NavItem.form,
            ),
            CustomNavBarIcon(
              icon: Icons.notifications,
              label: 'Notifications',
              navItem: NavItem.notifications,
              selected: _currentNavItem == NavItem.notifications,
            ),
          ],
        ),
      ),
    );
  }
}
