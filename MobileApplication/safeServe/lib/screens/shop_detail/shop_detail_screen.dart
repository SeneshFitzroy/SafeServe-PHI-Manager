import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';
import '../../../widgets/custom_nav_bar_icon.dart';
import '../../../widgets/custom_nav_bar_icon.dart' show NavItem;

import 'widgets/shop_detail_header.dart';
import 'widgets/shop_image.dart';
import 'widgets/shop_info_card.dart';
import 'widgets/form_buttons.dart';
import 'widgets/inspection_history.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopId; // Firestore doc ID
  const ShopDetailScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final _scroll = ScrollController();
  bool  _navVisible = true;

  final _shopsRef = FirebaseFirestore.instance.collection('shops');

  Future<Map<String, dynamic>> _fetch() async {
    final doc = await _shopsRef.doc(widget.shopId).get();
    if (!doc.exists) return {};
    return doc.data() as Map<String, dynamic>;
  }

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final dir = _scroll.position.userScrollDirection;
      if (dir == ScrollDirection.reverse && _navVisible) {
        setState(() => _navVisible = false);
      } else if (dir == ScrollDirection.forward && !_navVisible) {
        setState(() => _navVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
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
        FutureBuilder<Map<String, dynamic>>(
          future: _fetch(),
          builder: (ctx, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snap.data!;
            return _content(data);
          },
        ),
        _bottomNav(context),
      ]),
    );
  }


  Widget _content(Map<String, dynamic> d) => SingleChildScrollView(
    controller: _scroll,
    padding: const EdgeInsets.only(bottom: 80),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 30),
      ShopDetailHeader(
        shopName: d['name'] ?? widget.shopId,
        grade:    d['grade'] ?? 'N/A',
      ),
      const SizedBox(height: 30),
      ShopImage(imagePath: d['image'] ?? ''),
      const SizedBox(height: 30),
      ShopInfoCard(shopData: d),
      const SizedBox(height: 30),

      // Forms stub
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Text('Forms',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 15),
      const FormButtons(),
      const SizedBox(height: 40),

      // Inspection history
      InspectionHistory(
        inspectionTimestamps:
        (d['lastInspection'] as List?)?.cast<Timestamp>() ?? [],
      ),
    ]),
  );


  Widget _bottomNav(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width * 0.8;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
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
                navItem: NavItem.calendar),
            CustomNavBarIcon(
                icon: Icons.store,
                label: 'Shops',
                navItem: NavItem.shops,
                selected: true),
            CustomNavBarIcon(
                icon: Icons.dashboard,
                label: 'Dashboard',
                navItem: NavItem.dashboard),
            CustomNavBarIcon(
                icon: Icons.description, label: 'Form', navItem: NavItem.form),
            CustomNavBarIcon(
                icon: Icons.map, label: 'Map', navItem: NavItem.map),
          ],
        ),
      ),
    );
  }
}
