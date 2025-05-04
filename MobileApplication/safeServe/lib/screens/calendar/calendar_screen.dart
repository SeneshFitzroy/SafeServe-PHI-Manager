import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../services/auth_service.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/safe_serve_drawer.dart';
import '../../widgets/custom_nav_bar_icon.dart';
import '../../widgets/custom_nav_bar_icon.dart' show NavItem;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CollectionReference<Map<String, dynamic>> _tasksRef =
  FirebaseFirestore.instance.collection('tasks');
  final CollectionReference<Map<String, dynamic>> _shopsRef =
  FirebaseFirestore.instance.collection('shops');

  late final String _uid;
  late final DocumentReference<Map<String, dynamic>> _userRef;
  List<String> _userGnDivisions = [];

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _navVisible = true;

  Map<DateTime, List<Map<String, dynamic>>> _tasksByDay = {};

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final profile = await AuthService.instance.getCachedProfile();
    _uid = profile?['uid'] ?? '';
    _userRef = FirebaseFirestore.instance.collection('users').doc(_uid);

    final userSnap = await _userRef.get();
    final userData = userSnap.data();
    _userGnDivisions =
        (userData?['gnDivisions'] as List<dynamic>? ?? []).cast<String>();

    await _fetchData();
  }

  Future<void> _fetchData() async {
    final map = <DateTime, List<Map<String, dynamic>>>{};

    // Load normal tasks
    final tasksQ = await _tasksRef.where('phiId', isEqualTo: _userRef).get();
    for (final doc in tasksQ.docs) {
      final data = doc.data();
      final ts = data['date'] as Timestamp;
      final day =
      DateTime(ts.toDate().year, ts.toDate().month, ts.toDate().day);
      map.putIfAbsent(day, () => []).add({
        ...data,
        'isInspection': false,
      });
    }

    // Load upcoming inspections
    if (_userGnDivisions.isNotEmpty) {
      final batch = _userGnDivisions.length > 10
          ? _userGnDivisions.sublist(0, 10)
          : _userGnDivisions;
      final shopsQ =
      await _shopsRef.where('gnDivision', whereIn: batch).get();
      for (final doc in shopsQ.docs) {
        final data = doc.data();
        final Timestamp? upTs = data['upcomingInspection'] as Timestamp?;
        if (upTs == null) continue;
        final dt = upTs.toDate();
        final day = DateTime(dt.year, dt.month, dt.day);
        map.putIfAbsent(day, () => []).add({
          'title': 'Shop Inspection',
          'shopName': data['name'] ?? '',
          'notes': data['establishmentAddress'] ?? '',
          'date': upTs,
          'isInspection': true,
        });
      }
    }

    setState(() => _tasksByDay = map);
  }

  List<Map<String, dynamic>> _getTasksFor(DateTime d) {
    final key = DateTime(d.year, d.month, d.day);
    final list = _tasksByDay[key] ?? [];
    list.sort((a, b) =>
        (a['date'] as Timestamp).toDate().compareTo((b['date'] as Timestamp).toDate()));
    return list;
  }

  Color _colorForIndex(int i) {
    const palette = [
      Color(0xFF21AED7),
      Color(0xFFB0BEC5),
      Color(0xFFE53935),
      Color(0xFFFFC107),
      Color(0xFF43A047),
    ];
    return palette[i % palette.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () => Scaffold.of(context).openEndDrawer(),
      ),
      endDrawer: const SafeServeDrawer(
        profileImageUrl: '',
        userName: 'Kamal Rathanasighe',
        userPost: 'PHI',
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
            ),
          ),
        ),
        Column(children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TableCalendar(
              firstDay: DateTime.utc(2019, 1, 1),
              lastDay: DateTime.utc(2099, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (d) =>
              _selectedDay != null &&
                  d.year == _selectedDay!.year &&
                  d.month == _selectedDay!.month &&
                  d.day == _selectedDay!.day,
              onDaySelected: (sel, foc) {
                setState(() {
                  _selectedDay = sel;
                  _focusedDay = foc;
                });
              },
              eventLoader: _getTasksFor,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                headerPadding: EdgeInsets.only(bottom: 8),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.black54),
                weekendStyle: TextStyle(color: Colors.black54),
              ),
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(color: Colors.black87),
                weekendTextStyle: TextStyle(color: Colors.black87),
                todayDecoration: BoxDecoration(
                  color: Color(0xFF20C9B7),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF1F41BB),
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
              ),
              calendarFormat: CalendarFormat.month,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return const SizedBox();
                  final evts = events.cast<Map<String, dynamic>>();
                  final hasInspection =
                  evts.any((e) => e['isInspection'] == true);
                  final dotColor =
                  hasInspection ? Colors.red : const Color(0xFFF1D730);
                  return Positioned(
                    bottom: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: evts.map((_) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.5),
                          width: 7,
                          height: 7,
                          decoration:
                          BoxDecoration(color: dotColor, shape: BoxShape.circle),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildTimeline()),
        ]),
        _buildBottomNav(context),
      ]),
    );
  }

  Widget _buildTimeline() {
    final tasks = _getTasksFor(_selectedDay ?? _focusedDay);
    if (tasks.isEmpty) return const Center(child: Text('No tasks'));
    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n is ScrollUpdateNotification) {
          if (n.scrollDelta! > 0 && _navVisible) setState(() => _navVisible = false);
          if (n.scrollDelta! < 0 && !_navVisible) setState(() => _navVisible = true);
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: tasks.length,
        itemBuilder: (ctx, i) {
          final t     = tasks[i];
          final dt    = (t['date'] as Timestamp).toDate();
          final start = DateFormat('HH:mm').format(dt);
          final color = _colorForIndex(i);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Row(children: [
              SizedBox(
                width: 60,
                child: Text(start,
                    style: const TextStyle(fontSize: 16, color: Colors.black54)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => _showTaskPopup(t, start, color),
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['isInspection'] == true
                              ? '${t['title']} – ${t['shopName']}'
                              : t['title'] ?? '',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(t['notes'] ?? '',
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  void _showTaskPopup(Map<String, dynamic> task, String start, Color color) {
    final dt = (task['date'] as Timestamp).toDate();
    final dateStr = DateFormat('yyyy/MM/dd').format(dt);

    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16))),
              child: Text(
                task['title'] ?? '',
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(children: [
                const Icon(Icons.calendar_today,
                    size: 20, color: Colors.black54),
                const SizedBox(width: 8),
                Text('$dateStr • $start',
                    style:
                    const TextStyle(color: Colors.black87, fontSize: 14)),
              ]),
            ),
            if ((task['notes'] as String?)?.isNotEmpty ?? false)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(task['notes']!,
                    style:
                    const TextStyle(color: Colors.black87, fontSize: 14)),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: color,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('CLOSE',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width * 0.8;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      bottom: _navVisible ? 30 : -100,
      left: (MediaQuery.of(ctx).size.width - w) / 2,
      width: w,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6)
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNavBarIcon(
                icon: Icons.event,
                label: 'Calendar',
                navItem: NavItem.calendar,
                selected: true),
            CustomNavBarIcon(icon: Icons.store, label: 'Shops', navItem: NavItem.shops),
            CustomNavBarIcon(
                icon: Icons.dashboard, label: 'Dashboard', navItem: NavItem.dashboard),
            CustomNavBarIcon(icon: Icons.map, label: 'Map', navItem: NavItem.map),
            CustomNavBarIcon(
                icon: Icons.notifications,
                label: 'Notifications',
                navItem: NavItem.notifications),
          ],
        ),
      ),
    );
  }
}