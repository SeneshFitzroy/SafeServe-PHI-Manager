import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../../../widgets/safe_serve_drawer.dart';
import '../../../widgets/custom_nav_bar_icon.dart';
import 'widgets/shop_detail_header.dart';
import 'widgets/shop_image.dart';
import 'widgets/shop_info_card.dart';
import 'widgets/form_buttons.dart';
import 'widgets/inspection_history.dart';
import '../../../widgets/custom_nav_bar_icon.dart' show NavItem;

class ShopDetailScreen extends StatefulWidget {
  final String shopId; // doc ID in Firestore

  const ShopDetailScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  bool _isNavVisible = true;

  final CollectionReference shopsRef =
  FirebaseFirestore.instance.collection('shops');

  Future<Map<String, dynamic>> fetchShopDetail() async {
    // Attempt to read doc from Firestore
    final docSnap = await shopsRef.doc(widget.shopId).get();
    if (!docSnap.exists) {
      // If doc doesn’t exist, return minimal default
      return {
        'name': widget.shopId,
        'grade': 'N/A',
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

    final data = docSnap.data() as Map<String, dynamic>;
    // For the “inspectionHistory,” you might store it in Firestore, or default to empty
    return {
      'name': data['name'] ?? widget.shopId,
      'grade': data['grade'] ?? 'N/A',
      'image': data['image'] ?? 'assets/images/shop/shop1.png',
      'referenceNo': data['referenceNo'] ?? '------',
      'phiArea': data['phiArea'] ?? 'Unknown',
      'typeOfTrade': data['typeOfTrade'] ?? 'Unknown',
      'address': data['address'] ?? 'Unknown',
      'ownerName': data['ownerName'] ?? 'Unknown',
      'telephone': data['telephone'] ?? '-----',
      // If you want to store an array of inspectionHistory, handle that here:
      'inspectionHistory': data['inspectionHistory'] ?? [],
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
          // "Forms" Title
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
              selected: false,
            ),
            CustomNavBarIcon(
              icon: Icons.description,
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
    );
  }
}
