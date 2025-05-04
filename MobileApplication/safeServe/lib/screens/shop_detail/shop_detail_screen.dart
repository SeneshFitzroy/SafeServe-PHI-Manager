import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';
import '../../../widgets/custom_nav_bar_icon.dart';
import 'widgets/shop_detail_header.dart';
import 'widgets/shop_image.dart';
import 'widgets/shop_info_card.dart';
import 'widgets/form_buttons.dart';
import 'widgets/inspection_history.dart';
import '../h800_form/h800_form_data.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopId; // Firestore doc ID

  const ShopDetailScreen({super.key, required this.shopId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final _scroll = ScrollController();
  bool _navVisible = true;
  String? _phiId;
  final _shopsRef = FirebaseFirestore.instance.collection('shops');

  @override
  void initState() {
    super.initState();
    _fetchPhiId();
    _scroll.addListener(() {
      final dir = _scroll.position.userScrollDirection;
      if (dir == ScrollDirection.reverse && _navVisible) {
        setState(() => _navVisible = false);
      } else if (dir == ScrollDirection.forward && !_navVisible) {
        setState(() => _navVisible = true);
      }
    });
  }

  Future<void> _fetchPhiId() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        setState(() {
          _phiId = userDoc.data()?['phiId'] ?? userId; // Fallback to UID if phiId is missing
        });
      } else {
        setState(() {
          _phiId = userId;
        });
      }
    } catch (e) {
      print('Error fetching phiId: $e');
      setState(() {
        _phiId = FirebaseAuth.instance.currentUser?.uid ?? '';
      });
    }
  }

  Future<Map<String, dynamic>> _fetch() async {
    try {
      final doc = await _shopsRef.doc(widget.shopId).get();
      print('Fetching shop with ID: ${widget.shopId}');
      print('Document exists: ${doc.exists}');

      if (!doc.exists) {
        print('Document does not exist');
        return {
          'name': 'Unknown Shop',
          'grade': '',
          'image': '',
          'referenceNo': '------',
          'phiArea': 'Unknown',
          'typeOfTrade': 'Unknown',
          'address': 'Unknown',
          'ownerName': 'Unknown',
          'telephone': '-----',
          'inspectionHistory': <Timestamp>[],
        };
      }

      final data = doc.data();
      print('Fetched data: $data');

      if (data == null) {
        print('Data is null');
        return {
          'name': 'Unknown Shop',
          'grade': '',
          'image': '',
          'referenceNo': '------',
          'phiArea': 'Unknown',
          'typeOfTrade': 'Unknown',
          'address': 'Unknown',
          'ownerName': 'Unknown',
          'telephone': '-----',
          'inspectionHistory': <Timestamp>[],
        };
      }

      // Handle lastInspection as a list of timestamps
      final lastInspection = data['lastInspection'] as List<dynamic>?;
      List<Timestamp> inspectionTimestamps = [];
      if (lastInspection != null) {
        inspectionTimestamps = lastInspection.whereType<Timestamp>().toList();
      }

      return {
        'name': data['name'] ?? 'Unknown Shop',
        'grade': data['grade'] ?? '',
        'image': data['image'] ?? '',
        'referenceNo': data['referenceNo'] ?? '------',
        'phiArea': data['district'] ?? 'Unknown',
        'typeOfTrade': data['typeOfTrade'] ?? 'Unknown',
        'address': data['establishmentAddress'] ?? 'Unknown',
        'ownerName': data['ownerName'] ?? 'Unknown',
        'telephone': data['telephone'] ?? '-----',
        'inspectionHistory': inspectionTimestamps,
      };
    } catch (e) {
      print('Error fetching shop data: $e');
      return {
        'name': 'Error Loading Shop',
        'grade': '',
        'image': '',
        'referenceNo': '------',
        'phiArea': 'Unknown',
        'typeOfTrade': 'Unknown',
        'address': 'Unknown',
        'ownerName': 'Unknown',
        'telephone': '-----',
        'inspectionHistory': <Timestamp>[],
      };
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _startH800Form() {
    if (_phiId == null) {
      print('phiId not loaded yet');
      return;
    }
    Navigator.pushNamed(
      context,
      '/h800_form_screen',
      arguments: {
        'shopId': widget.shopId,
        'phiId': _phiId,
      },
    );
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
      body: Stack(
        children: [
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
              if (snap.hasError) {
                return const Center(child: Text('Error loading shop details'));
              }
              final data = snap.data!;
              return _content(data);
            },
          ),
          _bottomNav(context),
        ],
      ),
    );
  }

  Widget _content(Map<String, dynamic> d) => SingleChildScrollView(
        controller: _scroll,
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            ShopDetailHeader(
              shopName: d['name'] ?? widget.shopId,
              grade: d['grade'] ?? 'N/A',
            ),
            const SizedBox(height: 30),
            ShopImage(imagePath: d['image'] ?? ''),
            const SizedBox(height: 30),
            ShopInfoCard(shopData: d),
            const SizedBox(height: 30),
            // Forms stub
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Forms',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: _startH800Form,
              child: const FormButtons(),
            ),
            const SizedBox(height: 40),
            // Inspection history
            InspectionHistory(
              inspectionTimestamps: (d['inspectionHistory'] as List<Timestamp>?) ?? [],
            ),
          ],
        ),
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
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNavBarIcon(
              icon: Icons.event,
              label: 'Calendar',
              navItem: NavItem.calendar,
            ),
            CustomNavBarIcon(
              icon: Icons.store,
              label: 'Shops',
              navItem: NavItem.shops,
              selected: true,
            ),
            CustomNavBarIcon(
              icon: Icons.dashboard,
              label: 'Dashboard',
              navItem: NavItem.dashboard,
            ),
            CustomNavBarIcon(
              icon: Icons.description,
              label: 'Form',
              navItem: NavItem.form,
            ),
            CustomNavBarIcon(
              icon: Icons.map,
              label: 'Map',
              navItem: NavItem.map,
            ),
          ],
        ),
      ),
    );
  }
}