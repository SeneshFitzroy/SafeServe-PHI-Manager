import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';
import '../../../widgets/custom_nav_bar_icon.dart';
import 'widgets/shop_card.dart';

class RegisteredShopsScreen extends StatefulWidget {
  const RegisteredShopsScreen({super.key});

  @override
  State<RegisteredShopsScreen> createState() => _RegisteredShopsScreenState();
}

class _RegisteredShopsScreenState extends State<RegisteredShopsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  bool _isNavVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isNavVisible) {
        setState(() => _isNavVisible = false);
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isNavVisible) {
        setState(() => _isNavVisible = true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchShops() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'name': 'ABC Bakery & Café',
        'address': '123 Main Street, Colombo 07',
        'lastInspection': '01/02/2025',
        'grade': 'A',
        'image': 'assets/images/shop/shop1.png',
      },
      {
        'name': 'LUX Gift Shop',
        'address': '123 2nd Street, Colombo 07',
        'lastInspection': '01/05/2024',
        'grade': 'B',
        'image': 'assets/images/shop/shop2.png',
      },
    ];
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
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
              ),
            ),
          ),

          // Body content with shops
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchShops(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final shops = snapshot.data!;
              if (shops.isEmpty) {
                return const Center(child: Text('No shops found'));
              }
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 15),
                itemCount: shops.length + 1, // +1 for the header
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildBodyHeader();
                  }
                  final shop = shops[index - 1];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
                    child: ShopCard(
                      name: shop['name'],
                      address: shop['address'],
                      lastInspectionDate: shop['lastInspection'],
                      grade: shop['grade'],
                      imagePath: shop['image'],
                      onDetailsTap: () {
                        Navigator.pushNamed(context, '/shop_detail',
                            arguments: shop['name']);
                      },
                    ),
                  );
                },
              );
            },
          ),

          // Floating bottom nav
          _buildFloatingNavBar(context),
        ],
      ),
    );
  }

  Widget _buildBodyHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 15, 20),
      child: Row(
        children: [
          const Text(
            'Registered Shops',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF1F41BB)),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF1F41BB)),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double navWidth = screenWidth * 0.80;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      bottom: _isNavVisible ? 30 : -100,
      left: (screenWidth - navWidth) / 2,
      width: navWidth,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNavBarIcon(
              icon: Icons.event,
              label: 'Calendar',
              route: '/calendar',
              selected: false,
            ),
            CustomNavBarIcon(
              icon: Icons.store,
              label: 'Shops',
              route: '/',
              selected: true,
            ),
            CustomNavBarIcon(
              icon: Icons.dashboard,
              label: 'Dashboard',
              route: '/dashboard',
            ),
            CustomNavBarIcon(
              icon: Icons.description,
              label: 'Form',
              route: '/form',
            ),
            CustomNavBarIcon(
              icon: Icons.notifications,
              label: 'Notifications',
              route: '/notifications',
            ),
          ],
        ),
      ),
    );
  }
}
