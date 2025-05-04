import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';
import '../../../widgets/custom_nav_bar_icon.dart';
import '../../../widgets/custom_nav_bar_icon.dart' show NavItem;
import '../register_shop/register_shop_form_data.dart';
import '../register_shop/screen_one/register_shop_screen_one.dart';
import 'widgets/shop_card.dart';

class RegisteredShopsScreen extends StatefulWidget {
  const RegisteredShopsScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredShopsScreen> createState() => _RegisteredShopsScreenState();
}

class _RegisteredShopsScreenState extends State<RegisteredShopsScreen> {
  // Scaffold key to open the end drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Scroll controller to hide/show the nav bar
  final ScrollController _scrollController = ScrollController();
  bool _isNavVisible = true;

  // Firestore reference
  final CollectionReference _shopsRef =
  FirebaseFirestore.instance.collection('shops');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse && _isNavVisible) {
      setState(() => _isNavVisible = false);
    } else if (direction == ScrollDirection.forward && !_isNavVisible) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // attach the key here
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
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
              ),
            ),
          ),

          // Live list of shops
          StreamBuilder<QuerySnapshot>(
            stream: _shopsRef.snapshots(),
            builder: (ctx, snap) {
              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = snap.data!.docs;
              if (docs.isEmpty) {
                return const Center(child: Text('No shops found'));
              }
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 15),
                itemCount: docs.length + 1,
                itemBuilder: (ctx, i) {
                  if (i == 0) return _buildHeader(ctx);
                  final doc = docs[i - 1];
                  final data = doc.data()! as Map<String, dynamic>;

                  // extract lastInspection timestamp
                  final lastArr =
                      data['lastInspection'] as List<dynamic>? ?? [];
                  DateTime? lastDate;
                  if (lastArr.isNotEmpty && lastArr.first is Timestamp) {
                    lastDate = (lastArr.first as Timestamp).toDate();
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
                    child: ShopCard(
                      name: data['name'] ?? doc.id,
                      address: data['establishmentAddress'] ?? 'No address',
                      lastInspection: lastDate,
                      grade: data['grade'] ?? 'N/A',
                      imagePath: data['image'] ??
                          'assets/images/shop/shop1.png',
                      onDetailsTap: () {
                        Navigator.pushNamed(
                          context,
                          '/shop_detail',
                          arguments: doc.id,
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),

          _buildBottomNav(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 15, 20),
      child: Row(
        children: [
          const Text(
            'Registered Shops',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Color(0xFF1F41BB),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Color(0xFF1F41BB),
            ),
            onPressed: () {
              Navigator.push(
                ctx,
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
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
            )
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
              icon: Icons.notifications,
              label: 'Notifications',
              navItem: NavItem.notifications,
            ),
          ],
        ),
      ),
    );
  }
}
