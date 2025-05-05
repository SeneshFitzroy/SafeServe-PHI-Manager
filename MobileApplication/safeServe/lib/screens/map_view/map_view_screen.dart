// lib/screens/map_view/map_view_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

import '../../services/auth_service.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/custom_nav_bar_icon.dart' show CustomNavBarIcon, NavItem;

/// grade → pin colour
const _gradeColors = {
  'A': Color(0xFF3DB952),
  'B': Color(0xFFF1D730),
  'C': Color(0xFFFF8514),
  'D': Color(0xFFBB1F22),
};

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PopupController _popupCtrl = PopupController();

  final List<Marker> _markers = [];
  final Map<Marker, _Shop> _markerToShop = {};

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadShops();
  }

  Future<void> _loadShops() async {
    try {
      final cached = await AuthService.instance.getCachedProfile();
      if (cached == null) throw 'Not logged in';

      final gnDivs = List<String>.from(cached['gnDivisions']);

      for (var i = 0; i < gnDivs.length; i += 10) {
        final batch = gnDivs.sublist(i, (i + 10).clamp(0, gnDivs.length));

        final snap = await FirebaseFirestore.instance
            .collection('shops')
            .where('gnDivision', whereIn: batch)
            .get();

        for (final doc in snap.docs) {
          final d   = doc.data();
          final geo = d['location'] as GeoPoint?;
          if (geo == null) continue;

          final shop = _Shop(
            id: doc.id,
            name: d['name'] ?? 'Unnamed',
            address: d['establishmentAddress'] ?? 'No address',
            phone: d['telephone'] ?? '—',
            image: d['image'],
            grade: (d['grade'] ?? 'A').toString().toUpperCase(),
            point: LatLng(geo.latitude, geo.longitude),
          );

          final marker = Marker(
            point : shop.point,
            width : 40,
            height: 40,
            child : Icon(
              Icons.location_pin,
              size : 40,
              color: _gradeColors[shop.grade] ?? Colors.blue,
            ),
          );

          _markers.add(marker);
          _markerToShop[marker] = shop;
        }
      }
    } catch (e) {
      debugPrint('🔥 Map load error: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(
          center: _markers.isNotEmpty
              ? _markers.first.point
              : const LatLng(6.9271, 79.8612),
          zoom: 13,
          onTap: (_, __) => _popupCtrl.hideAllPopups(),
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.safe_serve',
          ),
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              markers: _markers,
              popupController: _popupCtrl,
              popupDisplayOptions: PopupDisplayOptions(
                builder: (ctx, marker) =>
                    _ShopPopup(shop: _markerToShop[marker]!),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNav(context),
    );
  }

  Widget _bottomNav(BuildContext ctx) => Container(
    height: 60,
    margin: const EdgeInsets.only(bottom: 20, left: 40, right: 40),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 6)
      ],
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomNavBarIcon(
            icon: Icons.event, label: 'Calendar', navItem: NavItem.calendar),
        CustomNavBarIcon(
            icon: Icons.store, label: 'Shops', navItem: NavItem.shops),
        CustomNavBarIcon(
            icon: Icons.dashboard, label: 'Dashboard', navItem: NavItem.dashboard),
        CustomNavBarIcon(
            icon: Icons.map, label: 'Map', navItem: NavItem.map, selected: true),
        CustomNavBarIcon(
            icon: Icons.notifications, label: 'Notifications', navItem: NavItem.notifications),
      ],
    ),
  );
}

/*──────────────────────── helper models & popup ─────────────────────*/

class _Shop {
  final String id, name, address, phone, grade;
  final String? image;
  final LatLng point;
  _Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.grade,
    required this.point,
    this.image,
  });
}

class _ShopPopup extends StatelessWidget {
  final _Shop shop;
  const _ShopPopup({required this.shop});

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: SizedBox(
      width: 240,
      height: 100,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: shop.image != null
                ? Image.network(
              shop.image!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.store, size: 60),
            )
                : const Icon(Icons.store, size: 60),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shop.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(shop.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 2),
                  Text('☎ ${shop.phone}',
                      style: const TextStyle(fontSize: 12)),
                ]),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: () => Navigator.pushNamed(
              context,
              '/shop_detail',
              arguments: shop.id,
            ),
          ),
        ],
      ),
    ),
  );
}
