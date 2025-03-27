import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';
import '../../../widgets/custom_nav_bar_icon.dart';
import 'widgets/shop_detail_header.dart';
import 'widgets/shop_image.dart';
import 'widgets/shop_info_card.dart';
import 'widgets/form_buttons.dart';
import 'widgets/inspection_history.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopId;

  const ShopDetailScreen({super.key, required this.shopId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  bool _isNavVisible = true;

  Future<Map<String, dynamic>> fetchShopDetail() async {
    await Future.delayed(const Duration(seconds: 1));

    final shopData = <String, Map<String, dynamic>>{
      'ABC Bakery & Café': {
        'name': 'ABC Bakery & Café',
        'grade': 'A',
        'image': 'assets/images/shop/shop1.png',
        'referenceNo': '15264568',
        'phiArea': 'Biyagama',
        'typeOfTrade': 'Bakery',
        'address': '585/A Makola North Makola',
        'ownerName': 'Leo Perera',
        'telephone': '071249582',
        'inspectionHistory': [
          {'date': '2025/01/26', 'grade': 'A'},
          {'date': '2024/12/15', 'grade': 'B'},
          {'date': '2024/09/15', 'grade': 'A'},
        ],
      },
      'LUX Gift Shop': {
        'name': 'LUX Gift Shop',
        'grade': 'B',
        'image': 'assets/images/shop/shop2.png',
        'referenceNo': '98765432',
        'phiArea': 'Colombo',
        'typeOfTrade': 'Retail',
        'address': '123 Main Street, Colombo',
        'ownerName': 'John Doe',
        'telephone': '077999888',
        'inspectionHistory': [
          {'date': '2025/03/01', 'grade': 'A'},
          {'date': '2024/10/09', 'grade': 'C'},
        ],
      },
    };

    return shopData[widget.shopId] ?? {
      'name': widget.shopId,
      'grade': 'A',
      'image': 'assets/images/shop/shop1.png',
      'referenceNo': '------',
      'phiArea': 'Unknown',
      'typeOfTrade': 'Unknown',
      'address': 'Unknown',
      'ownerName': 'Unknown',
      'telephone': '-----',
      'inspectionHistory': [],
    };
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isNavVisible) setState(() => _isNavVisible = false);
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isNavVisible) setState(() => _isNavVisible = true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          // Background
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
            future: fetchShopDetail(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = snapshot.data!;
              return _buildContent(context, data);
            },
          ),
          _buildFloatingNavBar(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, Map<String, dynamic> shopData) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          ShopDetailHeader(shopName: shopData['name'], grade: shopData['grade']),
          const SizedBox(height: 30),
          ShopImage(imagePath: shopData['image']),
          const SizedBox(height: 30),
          ShopInfoCard(shopData: shopData),
          const SizedBox(height: 30),
          // Now show 'Forms'
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Forms',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          const SizedBox(height: 15),
          const FormButtons(),
          const SizedBox(height: 40),
          // Inspection History
          InspectionHistory(inspectionData: shopData['inspectionHistory']),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final navWidth = screenWidth * 0.8;

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
            BoxShadow(color: Colors.black.withOpacity(0.15), offset: const Offset(0, 2), blurRadius: 6),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNavBarIcon(icon: Icons.event, label: 'Calendar', route: '/calendar', selected: false),
            CustomNavBarIcon(icon: Icons.store, label: 'Shops', route: '/', selected: true),
            CustomNavBarIcon(icon: Icons.dashboard, label: 'Dashboard', route: '/dashboard'),
            CustomNavBarIcon(icon: Icons.description, label: 'Form', route: '/form'),
            CustomNavBarIcon(icon: Icons.notifications, label: 'Notifications', route: '/notifications'),
          ],
        ),
      ),
    );
  }
}
