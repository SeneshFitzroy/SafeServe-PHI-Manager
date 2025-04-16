import 'package:flutter/material.dart';
import '../screens/registered_shops/registered_shops_screen.dart';

/// Simple enum to identify which icon is which
enum NavItem {
  calendar,
  shops,
  dashboard,
  form,
  tasks,
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
          case NavItem.tasks:
            // Already on tasks screen
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

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {'task': 'Complete project report', 'done': false},
    {'task': 'Team meeting at 2 PM', 'done': false},
  ];
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Current selected nav item
  NavItem _currentNavItem = NavItem.tasks;

  void _addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add({'task': task, 'done': false});
        _controller.clear();
      });
    }
  }

  void _toggleDone(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _onMenuPressed() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFEAF4FF),
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
              title: const Text('Tasks'),
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Add a new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addTask(_controller.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F41BB),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Checkbox(
                        value: _tasks[index]['done'],
                        onChanged: (val) => _toggleDone(index),
                      ),
                      title: Text(
                        _tasks[index]['task'],
                        style: TextStyle(
                          decoration: _tasks[index]['done']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
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
              label: 'Form',
              navItem: NavItem.form,
              selected: _currentNavItem == NavItem.form,
            ),
            CustomNavBarIcon(
              icon: Icons.task_alt,
              label: 'Tasks',
              navItem: NavItem.tasks,
              selected: _currentNavItem == NavItem.tasks,
            ),
          ],
        ),
      ),
    );
  }
}
