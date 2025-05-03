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
  final _scroll = ScrollController();
  bool  _navVisible = true;

  final _shopsRef = FirebaseFirestore.instance.collection('shops');

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_scrollListener);
  }

  void _scrollListener() {
    final dir = _scroll.position.userScrollDirection;
    if (dir == ScrollDirection.reverse && _navVisible) {
      setState(() => _navVisible = false);
    } else if (dir == ScrollDirection.forward && !_navVisible) {
      setState(() => _navVisible = true);
    }
  }

  @override
  void dispose() {
    _scroll.removeListener(_scrollListener);
    _scroll.dispose();
    super.dispose();
  }

  //---------------------------------------------------------------------------
  // UI
  //---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () =>
            Scaffold.of(context).openEndDrawer(),
      ),
      endDrawer: const SafeServeDrawer(
        profileImageUrl: '',
        userName: 'Kamal Rathanasighe',
        userPost: 'PHI',
      ),
      body: Stack(children: [
        // gradient
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
          stream: _shopsRef.snapshots(),            // works online & offline
          builder: (ctx, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snap.data!.docs;
            if (docs.isEmpty) {
              return const Center(child: Text('No shops found'));
            }

            return ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.only(top: 15),
              itemCount: docs.length + 1,
              itemBuilder: (ctx, i) {
                if (i == 0) return _header(context);
                final data = docs[i - 1].data()! as Map<String, dynamic>;

                // Extract & format
                final lastArr = data['lastInspection'] as List<dynamic>? ?? [];
                DateTime? lastDate;
                if (lastArr.isNotEmpty && lastArr.first is Timestamp) {
                  lastDate = (lastArr.first as Timestamp).toDate();
                }

                return Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
                  child: ShopCard(
                    name:  data['name']  ?? docs[i - 1].id,
                    address: data['establishmentAddress'] ?? 'No address',
                    lastInspection: lastDate,
                    grade: data['grade'] ?? 'N/A',
                    imagePath: data['image'] ?? 'assets/images/shop/shop1.png',
                    onDetailsTap: () {
                      Navigator.pushNamed(
                        context,
                        '/shop_detail',
                        arguments: docs[i - 1].id,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),

        _bottomNav(context),
      ]),
    );
  }

  //---------------------------------------------------------------------------
  // Widgets
  //---------------------------------------------------------------------------

  Widget _header(BuildContext ctx) => Padding(
    padding: const EdgeInsets.fromLTRB(25, 0, 15, 20),
    child: Row(children: [
      const Text('Registered Shops',
          style:
          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const Spacer(),
      IconButton(
          icon: const Icon(Icons.filter_list, color: Color(0xFF1F41BB)),
          onPressed: () {}),
      IconButton(
        icon: const Icon(Icons.add, color: Color(0xFF1F41BB)),
        onPressed: () {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (_) =>
                  RegisterShopScreenOne(formData: RegisterShopFormData()),
            ),
          );
        },
      )
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
            BoxShadow(
                color: Colors.black.withOpacity(0.15), blurRadius: 6)
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNavBarIcon(
                icon: Icons.event,
                label: 'Calendar',
                navItem: NavItem.calendar,
                selected: false),
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
                icon: Icons.description,
                label: 'Form',
                navItem: NavItem.form),
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
