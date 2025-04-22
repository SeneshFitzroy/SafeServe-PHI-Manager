import 'package:flutter/material.dart';
import '../../widgets/custom_nav_bar_icon.dart';
import '../registered_shops/registered_shops_screen.dart';
import '../../widgets/safe_serve_appbar.dart'; // Import the SafeServeAppBar

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  // Sample dynamic data
  static final List<Map<String, dynamic>> _upcomingInspections = [
    {
      'name': 'ABC Cafe & Bakery',
      'type': 'New Inspection',
      'date': '2025-05-07',
    },
    {
      'name': 'Kasun Stores',
      'type': 'New Inspection',
      'date': '2025-05-07',
    },
    {
      'name': 'Arunalu Resort',
      'type': 'New Inspection',
      'date': '2025-05-07',
    },
  ];

  // Dynamic task data
  static final Map<String, dynamic> _taskData = {
    'completed': {
      'count': '15',
      'period': 'This Month',
    },
    'pending': {
      'count': '05',
      'period': 'This Month',
    },
  };

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 80, 
        onMenuPressed: () => Scaffold.of(context).openDrawer(),
      ),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // Main content
          Container(
            width: screenWidth,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.50, -0.00),
                end: Alignment(0.50, 1.00),
                colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 90), // Extra padding for floating nav
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(),
                  _buildTasksOverview(),
                  _buildUpcomingInspections(),
                  _buildQuickActions(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // Floating navigation bar
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CustomNavBarIcon(
                    icon: Icons.calendar_today,
                    label: 'Calendar',
                    navItem: NavItem.calendar,
                  ),
                  CustomNavBarIcon(
                    icon: Icons.store,
                    label: 'Shops',
                    navItem: NavItem.shops,
                  ),
                  CustomNavBarIcon(
                    icon: Icons.dashboard,
                    label: 'Dashboard',
                    navItem: NavItem.dashboard,
                    selected: true,
                  ),
                  CustomNavBarIcon(
                    icon: Icons.assignment,
                    label: 'Forms',
                    navItem: NavItem.form,
                  ),
                  CustomNavBarIcon(
                    icon: Icons.notifications,
                    label: 'Alerts',
                    navItem: NavItem.notifications,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1F41BB),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.health_and_safety,
                    color: Color(0xFF1F41BB),
                    size: 30,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'SafeServe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'PHI Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: true,
            selectedTileColor: const Color(0xFFCDE6FE),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Registered Shops'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const RegisteredShopsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Calendar selected')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Forms'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Forms selected')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings selected')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 38, 25, 20),
      child: Row(
        children: [
          // Profile icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFCDE6FE),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF1F41BB),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFF1F41BB),
              size: 30,
            ),
          ),
          const SizedBox(width: 15),
          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good Morning',
                  style: TextStyle(
                    color: Color(0xFF1F41BB),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Kasun Rajitha Perera',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksOverview() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tasks Overview',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          _buildTaskCard(
            title: 'Completed Inspections',
            period: _taskData['completed']['period'],
            count: _taskData['completed']['count'],
          ),
          const SizedBox(height: 15),
          _buildTaskCard(
            title: 'Pending Inspections',
            period: _taskData['pending']['period'],
            count: _taskData['pending']['count'],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String period,
    required String count,
  }) {
    // Adjusting height to prevent overflow
    return Container(
      width: double.infinity,
      // Increase height to accommodate content without overflow
      constraints: const BoxConstraints(minHeight: 120),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2,
            color: Color(0xFF1F41BB),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Use min size to prevent overflow
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  period,
                  style: const TextStyle(
                    color: Color(0xFF828282),
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  count,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Add a circular icon that represents the task type
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: title.contains('Completed') 
                ? const Color(0xFFE6F5FE) 
                : const Color(0xFFF5ECF9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              title.contains('Completed') 
                ? Icons.check_circle 
                : Icons.pending_actions,
              color: const Color(0xFF1F41BB),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingInspections() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Inspections',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFF1F41BB),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _upcomingInspections.length,
              separatorBuilder: (context, index) => const Divider(
                thickness: 2,
                color: Color(0xFF1F41BB),
              ),
              itemBuilder: (context, index) {
                final inspection = _upcomingInspections[index];
                return _buildInspectionItem(
                  name: inspection['name'],
                  type: inspection['type'],
                  date: inspection['date'],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInspectionItem({
    required String name,
    required String type,
    required String date,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickActionItem(
                icon: Icons.store,
                label: 'Shops',
              ),
              _buildQuickActionItem(
                icon: Icons.calendar_month,
                label: 'Calendar',
              ),
              _buildQuickActionItem(
                icon: Icons.map,
                label: 'Map View',
              ),
            ],
          ),
          const SizedBox(height: 34),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickActionItem(
                icon: Icons.bar_chart,
                label: 'Reports',
              ),
              _buildQuickActionItem(
                icon: Icons.assignment,
                label: 'Forms',
              ),
              _buildQuickActionItem(
                icon: Icons.note,
                label: 'Notes',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({required IconData icon, required String label}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 103,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 45,
                color: const Color(0xFF1F41BB),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
