import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/auth_service.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/custom_nav_bar_icon.dart' show CustomNavBarIcon, NavItem;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String _uid;
  late List<String> _gnDivisions;

  String  _fullName        = '– –';
  String? _profileUrl;
  int?    _completedCount;
  int?    _pendingCount;
  List<UpcomingInspection> _upcoming = [];

  bool _loading = true;
  final _dateFmt = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    try {
      final cached = await AuthService.instance.getCachedProfile();
      if (cached == null) {
        throw StateError('No cached profile – you must log in.');
      }
      _uid         = cached['uid'] as String;
      _gnDivisions = List<String>.from(cached['gnDivisions']);

      // Fetch user info
      final userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .get();
      final userData = userSnap.data()!;
      _fullName   = userData['fullName'] as String? ?? 'Unnamed PHI';
      _profileUrl = userData['profilePicture'] as String?;

      // Load the rest
      await Future.wait([
        _loadCompletedInspections(),
        _loadPendingAndUpcoming(),
      ]);
    } catch (e, st) {
      debugPrint('🔥 Dashboard init error: $e\n$st');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loadCompletedInspections() async {
    final now   = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final end   = DateTime(now.year, now.month + 1, 1)
        .subtract(const Duration(milliseconds: 1));

    final snap = await FirebaseFirestore.instance
        .collection('h800_forms')
        .where('phiId',
        isEqualTo:
        FirebaseFirestore.instance.doc('users/$_uid'))
        .get();

    int count = 0;
    for (final doc in snap.docs) {
      final ts = (doc['timestamp'] as Timestamp).toDate();
      if (!ts.isBefore(start) && !ts.isAfter(end)) count++;
    }
    _completedCount = count;
  }

  Future<void> _loadPendingAndUpcoming() async {
    final now        = DateTime.now();
    final endOfMonth = DateTime(now.year, now.month + 1, 1)
        .subtract(const Duration(milliseconds: 1));

    int pending = 0;
    final List<UpcomingInspection> upcoming = [];

    // Firestore caps whereIn to 10 items
    for (var i = 0; i < _gnDivisions.length; i += 10) {
      final batch = _gnDivisions.sublist(
        i,
        (i + 10).clamp(0, _gnDivisions.length),
      );

      final snap = await FirebaseFirestore.instance
          .collection('shops')
          .where('gnDivision', whereIn: batch)
          .get();

      for (final doc in snap.docs) {
        if (!doc.data().containsKey('upcomingInspection')) continue;
        final ts = (doc['upcomingInspection'] as Timestamp).toDate();

        // future? and within this month?
        if (ts.isAfter(now.subtract(const Duration(milliseconds: 1))) &&
            !ts.isAfter(endOfMonth)) {
          pending++;
          upcoming.add(UpcomingInspection(
            doc['name'] as String? ?? 'Unnamed Shop',
            'New Inspection',
            _dateFmt.format(ts),
            ts,
          ));
        }
      }
    }

    upcoming.sort((a, b) => a.rawDate.compareTo(b.rawDate));
    _pendingCount = pending;
    _upcoming     = upcoming;
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  int _safeInt(int? v) => v ?? 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
      body: Stack(children: [
        const _DashboardGradient(),
        if (_loading)
          const Center(child: CircularProgressIndicator())
        else
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_greeting(),
                                style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1F41BB))),
                            const SizedBox(height: 4),
                            Text(_fullName,
                                style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                          ]),
                    ),
                    _ProfileAvatar(url: _profileUrl),
                  ]),
                ),
                const SizedBox(height: 30),
                const _SectionTitle('Tasks Overview'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children: [
                    _taskCard(
                      title: 'Completed Inspections',
                      sub:   'This Month',
                      count: _safeInt(_completedCount),
                      icon:  Icons.check_circle_outline,
                      iconColor: const Color(0xFF3DB952),
                      width: w - 50,
                    ),
                    const SizedBox(height: 18),
                    _taskCard(
                      title: 'Pending Inspections',
                      sub:   'This Month',
                      count: _safeInt(_pendingCount),
                      icon:  Icons.error_outline,
                      iconColor: const Color(0xFFBB1F22),
                      width: w - 50,
                    ),
                  ]),
                ),
                const SizedBox(height: 35),
                const _SectionTitle('Upcoming Inspections'),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    constraints:
                    const BoxConstraints(minHeight: 180, maxHeight: 260),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF1F41BB)),
                    ),
                    child: _upcoming.isEmpty
                        ? const Center(child: Text('No upcoming inspections.'))
                        : ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: _upcoming.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFF1F41BB),
                      ),
                      itemBuilder: (_, i) =>
                          _upcomingTile(_upcoming[i]),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                _buildQuickActions(),
              ],
            ),
          ),
        _bottomNav(context),
      ]),
    );
  }

  Widget _taskCard({
    required String title,
    required String sub,
    required int    count,
    required IconData icon,
    required Color iconColor,
    required double width,
  }) =>
      Container(
        width: width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF1F41BB)),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(sub,
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                const SizedBox(height: 12),
                Text('$count',
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Icon(icon, color: iconColor, size: 38),
        ]),
      );

  Widget _upcomingTile(UpcomingInspection u) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    child: Row(children: [
      Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(u.name,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(u.type,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ]),
      ),
      Text(u.date,
          style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w400)),
    ]),
  );

  Widget _buildQuickActions() {
    Widget item(IconData i, String lbl, {VoidCallback? tap}) => InkWell(
      onTap: tap,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF4289FC)),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(i, color: const Color(0xFF4289FC), size: 34),
              const SizedBox(height: 6),
              Text(lbl,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4289FC))),
            ]),
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Quick Actions',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 25,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          item(Icons.store, 'Shops', tap: () => Navigator.pushNamed(context, '/')),
          item(Icons.calendar_month, 'Calendar', tap: () => Navigator.pushNamed(context, '/calendar')),
          item(Icons.map, 'Map View', tap: () => Navigator.pushNamed(context, '/map')),
        ]),
        const SizedBox(height: 34),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          item(Icons.bar_chart, 'Reports', tap: () => Navigator.pushNamed(context, '/reports')),
          item(Icons.assignment, 'Forms', tap: () => Navigator.pushNamed(context, '/form')),
          item(Icons.note, 'Notes', tap: () => Navigator.pushNamed(context, '/notes')),
        ]),
      ]),
    );
  }

  Widget _bottomNav(BuildContext ctx) {
    final width = MediaQuery.of(ctx).size.width * 0.8;
    return Positioned(
      bottom: 30,
      left: (MediaQuery.of(ctx).size.width - width) / 2,
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNavBarIcon(icon: Icons.event, label: 'Calendar', navItem: NavItem.calendar),
            CustomNavBarIcon(icon: Icons.store, label: 'Shops', navItem: NavItem.shops),
            CustomNavBarIcon(icon: Icons.dashboard, label: 'Dashboard', navItem: NavItem.dashboard, selected: true),
            CustomNavBarIcon(icon: Icons.description, label: 'Form', navItem: NavItem.form),
            CustomNavBarIcon(icon: Icons.notifications, label: 'Notifications', navItem: NavItem.notifications),
          ],
        ),
      ),
    );
  }
}

class UpcomingInspection {
  final String name, type, date;
  final DateTime rawDate;
  UpcomingInspection(this.name, this.type, this.date, this.rawDate);
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Text(text,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 25,
          fontWeight: FontWeight.w700,
        )),
  );
}

class _DashboardGradient extends StatelessWidget {
  const _DashboardGradient();

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
      ),
    ),
  );
}

class _ProfileAvatar extends StatelessWidget {
  final String? url;
  const _ProfileAvatar({this.url});

  @override
  Widget build(BuildContext context) {
    const placeholder = 'assets/images/other/profile_placeholder.jpg';
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFE6F5FE),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFF1F41BB), width: 2),
      ),
      child: ClipOval(
        child: url == null || url!.isEmpty
            ? Image.asset(placeholder, fit: BoxFit.cover)
            : Image.network(
          url!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Image.asset(placeholder),
        ),
      ),
    );
  }
}
