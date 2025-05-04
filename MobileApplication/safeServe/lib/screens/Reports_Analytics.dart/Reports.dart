import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/custom_nav_bar_icon.dart';
import '../../widgets/safe_serve_drawer.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  String selectedMonth = DateTime.now().month > 0
      ? [
          'January', 'February', 'March', 'April', 'May', 'June',
          'July', 'August', 'September', 'October', 'November', 'December'
        ][DateTime.now().month - 1]
      : 'March';

  final Map<String, int> inspectionsPerMonth = {
    'January': 12,
    'February': 18,
    'March': 25,
    'April': 20,
    'May': 16,
    'June': 22,
    'July': 19,
    'August': 23,
    'September': 21,
    'October': 17,
    'November': 14,
    'December': 20,
  };

  final Map<String, double> gradingDistribution = {
    'A': 40,
    'B': 30,
    'C': 20,
    'D': 10,
  };

  final Map<String, double> shopTypeDistribution = {
    'Restaurants': 35,
    'Grocery': 25,
    'Bakery': 20,
    'Hotels': 20,
  };

  void _onMenuPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onViewOutput() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('View Output Pressed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double chartWidth = MediaQuery.of(context).size.width - 50; // margin 25 left/right
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeServeDrawer(
        profileImageUrl: '',
        userName: 'John Doe',
        userPost: 'Health Inspector',
      ),
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: _onMenuPressed,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Reports & Analytics',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // No of Inspections per Month with Bar Chart
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'No of Inspections per Month',
                        style: TextStyle(
                          color: Color(0xFF1F41BB),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Month:',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            value: selectedMonth,
                            items: months.map((month) {
                              return DropdownMenuItem(
                                value: month,
                                child: Text(month),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMonth = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: chartWidth,
                        height: 200,
                        child: BarChart(
                          data: inspectionsPerMonth,
                          selectedMonth: selectedMonth,
                          barColor: const Color(0xFF1F41BB),
                          highlightColor: const Color(0xFFCDE6FE),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Shop Grading Distribution
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shop Grading Distribution',
                        style: TextStyle(
                          color: Color(0xFF1F41BB),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: CustomPaint(
                            painter: PieChartPainter(gradingDistribution),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 8,
                        children: gradingDistribution.entries.map((e) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  color: _gradeColor(e.key),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text('${e.key} Grade: ${e.value.toInt()}%'),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Shop Types Distribution
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shop Types Distribution',
                        style: TextStyle(
                          color: Color(0xFF1F41BB),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: CustomPaint(
                            painter: PieChartPainter(shopTypeDistribution),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 8,
                        children: shopTypeDistribution.entries.map((e) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  color: _shopTypeColor(e.key),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text('${e.key}: ${e.value.toInt()}%'),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
            Positioned(
              left: 25,
              right: 25,
              bottom: 20,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomNavBarIcon(
                        icon: Icons.calendar_month,
                        label: 'Calendar',
                        navItem: NavItem.calendar,
                        selected: false,
                      ),
                      CustomNavBarIcon(
                        icon: Icons.store,
                        label: 'Shops',
                        navItem: NavItem.shops,
                        selected: false,
                      ),
                      CustomNavBarIcon(
                        icon: Icons.dashboard,
                        label: 'Dashboard',
                        navItem: NavItem.dashboard,
                        selected: true,
                      ),
                      CustomNavBarIcon(
                        icon: Icons.assignment,
                        label: 'Form',
                        navItem: NavItem.form,
                        selected: false,
                      ),
                      CustomNavBarIcon(
                        icon: Icons.notifications,
                        label: 'Notifications',
                        navItem: NavItem.notifications,
                        selected: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _gradeColor(String grade) {
    switch (grade) {
      case 'A': return Colors.green;
      case 'B': return Colors.blue;
      case 'C': return Colors.orange;
      case 'D': return Colors.red;
      default: return Colors.grey;
    }
  }

  Color _shopTypeColor(String type) {
    switch (type) {
      case 'Restaurants': return Colors.purple;
      case 'Grocery': return Colors.teal;
      case 'Bakery': return Colors.brown;
      case 'Hotels': return Colors.indigo;
      default: return Colors.grey;
    }
  }
}

// Bar Chart for Inspections per Month
class BarChart extends StatelessWidget {
  final Map<String, int> data;
  final String selectedMonth;
  final Color barColor;
  final Color highlightColor;

  const BarChart({
    super.key,
    required this.data,
    required this.selectedMonth,
    required this.barColor,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final maxVal = data.values.reduce((a, b) => a > b ? a : b);
    final barCount = data.length;
    final barSpacing = 4.0;
    final barWidth = ((MediaQuery.of(context).size.width - 90) / barCount).clamp(10.0, 30.0);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.entries.map((entry) {
          final isSelected = entry.key == selectedMonth;
          final barHeight = (entry.value / maxVal) * 120 + 20;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: barSpacing / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: barHeight,
                  width: barWidth,
                  decoration: BoxDecoration(
                    color: isSelected ? highlightColor : barColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${entry.value}',
                      style: TextStyle(
                        color: isSelected ? barColor : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  entry.key.substring(0, 3),
                  style: TextStyle(
                    color: isSelected ? barColor : Colors.black54,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Simple Pie Chart Painter for demonstration
class PieChartPainter extends CustomPainter {
  final Map<String, double> dataMap;
  PieChartPainter(this.dataMap);

  @override
  void paint(Canvas canvas, Size size) {
    double total = dataMap.values.fold(0, (a, b) => a + b);
    double startRadian = -3.14 / 2;
    final radius = size.width / 3;
    final center = Offset(size.width / 2, size.height / 2);

    dataMap.forEach((key, value) {
      final sweepRadian = (value / total) * 3.14 * 2;
      final paint = Paint()
        ..color = key == 'A'
            ? Colors.green
            : key == 'B'
                ? Colors.blue
                : key == 'C'
                    ? Colors.orange
                    : key == 'D'
                        ? Colors.red
                        : key == 'Restaurants'
                            ? Colors.purple
                            : key == 'Grocery'
                                ? Colors.teal
                                : key == 'Bakery'
                                    ? Colors.brown
                                    : key == 'Hotels'
                                        ? Colors.indigo
                                        : Colors.grey
        ..style = PaintingStyle.stroke
        ..strokeWidth = 28;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      startRadian += sweepRadian;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
