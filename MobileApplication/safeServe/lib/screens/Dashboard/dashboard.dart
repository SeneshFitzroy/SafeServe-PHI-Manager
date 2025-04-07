import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              _buildGreeting(),
              _buildTasksOverview(),
              _buildUpcomingInspections(),
              _buildQuickActions(),
              const SizedBox(height: 20), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 38,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/36x38"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'SafeServe',
              style: TextStyle(
                color: Color(0xFF1F41BB),
                fontSize: 25,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            _buildIconButton(color: const Color(0xFFCDE6FE)),
            const SizedBox(width: 15),
            _buildIconButton(color: const Color(0xFFCDE6FE)),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({required Color color}) {
    return Container(
      width: 35,
      height: 35,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: color),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(34, 38, 34, 20),
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
    );
  }

  Widget _buildTasksOverview() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(34, 20, 34, 30),
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
            period: 'This Month',
            count: '15',
          ),
          const SizedBox(height: 15),
          _buildTaskCard(
            title: 'Pending Inspections',
            period: 'This Month',
            count: '05',
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
    return Container(
      width: 350,
      height: 112,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Widget _buildUpcomingInspections() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(34, 0, 34, 30),
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
          _buildInspectionsCard(),
          const SizedBox(height: 10),
          _buildScheduleButton(),
        ],
      ),
    );
  }

  Widget _buildInspectionsCard() {
    return Container(
      width: 350,
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
      child: Column(
        children: [
          _buildInspectionItem(
            name: 'ABC Cafe & Bakery',
            type: 'New Inspection',
            date: '2025-05-07',
          ),
          const Divider(
            thickness: 2,
            color: Color(0xFF1F41BB),
          ),
          _buildInspectionItem(
            name: 'Kasun Stores',
            type: 'New Inspection',
            date: '2025-05-07',
          ),
          const Divider(
            thickness: 2,
            color: Color(0xFF1F41BB),
          ),
          _buildInspectionItem(
            name: 'Arunalu Resort',
            type: 'New Inspection',
            date: '2025-05-07',
          ),
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

  Widget _buildScheduleButton() {
    return Center(
      child: Container(
        width: 318,
        height: 60,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.add_circle_outline, size: 30),
            Container(
              width: 53,
              height: 54,
              decoration: const ShapeDecoration(
                color: Color(0xFFCDE6FE),
                shape: OvalBorder(),
              ),
              child: const Icon(Icons.calendar_today, size: 24),
            ),
            const Icon(Icons.arrow_forward, size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(34, 0, 34, 20),
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
                image: "https://placehold.co/57x57",
                label: 'Shops',
              ),
              _buildQuickActionItem(
                image: "https://placehold.co/51x51",
                label: 'Calendar',
              ),
              _buildQuickActionItem(
                image: "https://placehold.co/52x52",
                label: 'Map View',
              ),
            ],
          ),
          const SizedBox(height: 34),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickActionItem(
                image: "https://placehold.co/56x56",
                label: 'Reports',
              ),
              _buildQuickActionItem(
                image: "https://placehold.co/69x69",
                label: 'Forms',
              ),
              _buildQuickActionItem(
                image: "https://placehold.co/60x64",
                label: 'Notes',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({required String image, required String label}) {
    return Container(
      width: 101,
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
          Container(
            width: 57,
            height: 57,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
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
    );
  }
}
