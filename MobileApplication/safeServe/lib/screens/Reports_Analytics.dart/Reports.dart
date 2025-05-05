import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/custom_nav_bar_icon.dart';
import '../../widgets/safe_serve_drawer.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasShownError = false;
  bool _isNavVisible = true;

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

  Map<String, int> inspectionsPerMonth = {};
  Map<String, double> gradingDistribution = {};
  Map<String, double> shopTypeDistribution = {};
  Map<String, Color> shopTypeColors = {};
  Map<String, Color> gradeColors = {
    'A': Colors.green,
    'B': Colors.blue,
    'C': Colors.orange,
    'D': Colors.red,
    'Unknown': Colors.grey,
  };

  Stream<QuerySnapshot>? formsStream;
  Stream<QuerySnapshot>? shopsStream;

  // List of colors to assign dynamically to shop types
  final List<Color> typeColors = [
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.orange,
    Colors.pink,
    Colors.cyan,
    Colors.amber,
    Colors.grey, // Fallback for unknown
  ];

  @override
  void initState() {
    super.initState();
    formsStream = FirebaseFirestore.instance.collection('h800_forms').snapshots();
    shopsStream = FirebaseFirestore.instance.collection('shops').snapshots();
  }

  void _updateDataFromFirestore(QuerySnapshot formsSnapshot, QuerySnapshot shopsSnapshot) {
    try {
      // Inspections per Month
      Map<String, int> inspections = { for (var m in months) m: 0 };
      for (var doc in formsSnapshot.docs) {
        final ts = (doc['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();
        final monthName = months[ts.month - 1];
        inspections[monthName] = (inspections[monthName] ?? 0) + 1;
      }

      // Shop Grading Distribution
      Map<String, int> gradesCount = {'A': 0, 'B': 0, 'C': 0, 'D': 0};
      for (var doc in formsSnapshot.docs) {
        final grade = doc['grade'] as String? ?? 'Unknown';
        gradesCount[grade] = (gradesCount[grade] ?? 0) + 1;
      }
      final totalForms = formsSnapshot.docs.length;
      Map<String, double> gradesDist = {
        for (var e in gradesCount.entries)
          e.key: totalForms > 0 ? e.value / totalForms * 100 : 0
      };

      // Shop Types Distribution
      Map<String, int> shopTypesCount = {};
      for (var doc in shopsSnapshot.docs) {
        final type = (doc['typeOfTrade'] as String?)?.trim() ?? 'Unknown';
        shopTypesCount[type] = (shopTypesCount[type] ?? 0) + 1;
      }
      final totalShops = shopsSnapshot.docs.length;
      final Map<String, double> typesDist = {};
      final Map<String, Color> typeColorMap = {};
      int colorIndex = 0;
      shopTypesCount.forEach((type, count) {
        typesDist[type] = totalShops > 0 ? count / totalShops * 100 : 0;
        typeColorMap[type] = typeColors[colorIndex++ % typeColors.length];
      });

      setState(() {
        inspectionsPerMonth = inspections;
        gradingDistribution = gradesDist;
        shopTypeDistribution = typesDist;
        shopTypeColors = typeColorMap;
        _hasShownError = false;
      });
    } catch (e) {
      if (!_hasShownError) {
        _hasShownError = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error fetching data: $e')));
        });
      }
    }
  }

  void _onMenuPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final double chartWidth = MediaQuery.of(context).size.width - 50;

    return StreamBuilder<QuerySnapshot>(
      stream: formsStream,
      builder: (context, formsSnapshot) {
        return StreamBuilder<QuerySnapshot>(
          stream: shopsStream,
          builder: (context, shopsSnapshot) {
            if (formsSnapshot.connectionState == ConnectionState.waiting ||
                shopsSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
            if (formsSnapshot.hasError || shopsSnapshot.hasError) {
              return const Scaffold(
                  body: Center(child: Text('Error loading data')));
            }
            if (!formsSnapshot.hasData || !shopsSnapshot.hasData) {
              return const Scaffold(
                  body: Center(child: Text('No data available')));
            }

            _updateDataFromFirestore(
                formsSnapshot.data!, shopsSnapshot.data!);

            return Scaffold(
              key: _scaffoldKey,
              appBar: SafeServeAppBar(
                height: 70,
                onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
              endDrawer: const SafeServeDrawer(),
              body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
                  ),
                ),
                child: inspectionsPerMonth.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 18),
                      children: [
                        const Text(
                          'Reports & Analytics',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Inspections per Month
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
                                  const Text('Month:',
                                      style: TextStyle(fontSize: 16)),
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
                                  highlightColor:
                                  const Color(0xFFCDE6FE),
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
                                  height: 180,
                                  width: 180,
                                  child: CustomPaint(
                                    painter: PieChartPainter(
                                        gradingDistribution,
                                        gradeColors),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 16,
                                runSpacing: 8,
                                children: gradingDistribution.entries
                                    .map((e) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 12, height: 12,
                                        margin: const EdgeInsets.only(
                                            right: 6),
                                        decoration: BoxDecoration(
                                          color:
                                          gradeColors[e.key] ??
                                              Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Text(
                                          '${e.key} Grade: ${e.value.toStringAsFixed(1)}%'),
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
                                  height: 180,
                                  width: 180,
                                  child: CustomPaint(
                                    painter: PieChartPainter(
                                        shopTypeDistribution,
                                        shopTypeColors),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 16,
                                runSpacing: 8,
                                children: shopTypeDistribution.entries
                                    .map((e) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 12, height: 12,
                                        margin: const EdgeInsets.only(
                                            right: 6),
                                        decoration: BoxDecoration(
                                          color:
                                          shopTypeColors[e.key] ??
                                              Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Text(
                                          '${e.key}: ${e.value.toStringAsFixed(1)}%'),
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

                    // animated bottom nav
                    _buildBottomNav(context),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext ctx) {
    final width = MediaQuery.of(ctx).size.width * 0.8;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      bottom: _isNavVisible ? 30 : -100,
      left: (MediaQuery.of(ctx).size.width - width) / 2,
      width: width,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            CustomNavBarIcon(
              icon: Icons.event,
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
              selected: false,
            ),
            CustomNavBarIcon(
              icon: Icons.map,
              label: 'Form',
              navItem: NavItem.map,
              selected: false,
            ),
            CustomNavBarIcon(
              icon: Icons.assessment,
              label: 'Notifications',
              navItem: NavItem.Report,
              selected: true,
            ),
          ],
        ),
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  final Map<String, int> data;
  final String selectedMonth;
  final Color barColor;
  final Color highlightColor;

  const BarChart({
    Key? key,
    required this.data,
    required this.selectedMonth,
    required this.barColor,
    required this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxVal = data.values.isEmpty ? 1 : data.values.reduce((a, b) => a > b ? a : b);
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

class PieChartPainter extends CustomPainter {
  final Map<String, double> dataMap;
  final Map<String, Color> colorMap;

  PieChartPainter(this.dataMap, this.colorMap);

  @override
  void paint(Canvas canvas, Size size) {
    double total = dataMap.values.fold(0, (a, b) => a + b);
    if (total == 0) total = 1;
    double startRadian = -3.14 / 2;
    final radius = size.width / 3;
    final center = Offset(size.width / 2, size.height / 2);

    dataMap.forEach((key, value) {
      final sweepRadian = (value / total) * 3.14 * 2;
      final paint = Paint()
        ..color = colorMap[key] ?? Colors.grey
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        true,
        paint,
      );
      startRadian += sweepRadian;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
