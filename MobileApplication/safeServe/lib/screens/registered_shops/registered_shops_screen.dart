// lib/screens/registered_shops/registered_shops_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';
import '../../../widgets/custom_nav_bar_icon.dart';
import '../register_shop/register_shop_form_data.dart';
import '../register_shop/screen_one/register_shop_screen_one.dart';
import 'widgets/shop_card.dart';
import '../../../widgets/custom_nav_bar_icon.dart' show NavItem;

class RegisteredShopsScreen extends StatefulWidget {
  const RegisteredShopsScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredShopsScreen> createState() => _RegisteredShopsScreenState();
}

class _RegisteredShopsScreenState extends State<RegisteredShopsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  bool _isNavVisible = true;

  final CollectionReference shopsRef =
  FirebaseFirestore.instance.collection('shops');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final dir = _scrollController.position.userScrollDirection;
    if (dir == ScrollDirection.reverse && _isNavVisible) {
      setState(() => _isNavVisible = false);
    } else if (dir == ScrollDirection.forward && !_isNavVisible) {
      setState(() => _isNavVisible = true);
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchShops() async {
    final snapshot = await shopsRef.get();
    return snapshot.docs.map((doc) {
      final data = doc.data()! as Map<String, dynamic>;
      return {
        'name': data['name'] ?? doc.id,
        'address': data['address'] ?? 'No address',
        'lastInspection': data['lastInspection'] ?? 'N/A',
        'grade': data['grade'] ?? 'N/A',
        'image': data['image'] ?? 'assets/images/shop/shop1.png',
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
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

          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchShops(),
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.hasError) {
                return Center(
                  child: Text(
                    'Error loading shops:\n${snap.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              final shops = snap.data!;
              if (shops.isEmpty) {
                return const Center(child: Text('No shops found'));
              }
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 15),
                itemCount: shops.length + 1,
                itemBuilder: (ctx, i) {
                  if (i == 0) return _buildBodyHeader();
                  final shop = shops[i - 1];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
                    child: ShopCard(
                      name: shop['name'],
                      address: shop['address'],
                      lastInspectionDate: shop['lastInspection'],
                      grade: shop['grade'],
                      imagePath: shop['image'],
                      onDetailsTap: () {
                        Navigator.pushNamed(
                          context,
                          '/shop_detail',
                          arguments: shop['name'],
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),

          _buildFloatingNavBar(context),
        ],
      ),
    );
  }

  Widget _buildBodyHeader() => Padding(
    padding: const EdgeInsets.fromLTRB(25, 0, 15, 20),
    child: Row(
      children: [
        const Text(
          'Registered Shops',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.filter_list, color: Color(0xFF1F41BB)),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Color(0xFF1F41BB)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RegisterShopScreenOne(
                  formData: RegisterShopFormData(),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );

  Widget _buildFloatingNavBar(BuildContext context) {
    final w = MediaQuery.of(context).size.width * 0.8;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      bottom: _isNavVisible ? 30 : -100,
      left: (MediaQuery.of(context).size.width - w) / 2,
      width: w,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            CustomNavBarIcon(icon: Icons.event, label: 'Calendar', navItem: NavItem.calendar, selected: false),
            CustomNavBarIcon(icon: Icons.store, label: 'Shops', navItem: NavItem.shops, selected: true),
            CustomNavBarIcon(icon: Icons.dashboard, label: 'Dashboard', navItem: NavItem.dashboard),
            CustomNavBarIcon(icon: Icons.description, label: 'Form', navItem: NavItem.form),
            CustomNavBarIcon(icon: Icons.notifications, label: 'Notifications', navItem: NavItem.notifications),
          ],
        ),
      ),
    );
  }
}