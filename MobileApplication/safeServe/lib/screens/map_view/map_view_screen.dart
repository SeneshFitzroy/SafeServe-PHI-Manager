import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/safe_serve_drawer.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/custom_nav_bar_icon.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final MapController _mapController = MapController();
  final LatLng _initialPosition = LatLng(6.9349, 79.8507); // Pettah, Sri Lanka
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _shops = [];
  int _currentShopIndex = 0;

  @override
  void initState() {
    super.initState();
    _listenToShops();
  }

  // Listen to Firestore changes in real time
  void _listenToShops() {
    FirebaseFirestore.instance.collection('shops').snapshots().listen(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          print('No shops found in Firestore');
        } else {
          print('Updated with ${snapshot.docs.length} shops');
        }
        setState(() {
          _shops = snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return data;
          }).toList();
          // Reset index if it exceeds the new list length
          if (_shops.isNotEmpty && _currentShopIndex >= _shops.length) {
            _currentShopIndex = 0;
          }
        });
      },
      onError: (e) {
        print('Error listening to shops: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load shops: $e')),
        );
      },
    );
  }

  void _showShopDetails(BuildContext context, Map<String, dynamic> shop) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shop['name'] ?? 'Unknown Shop',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Business Reg Number: ${shop['businessRegNumber'] ?? 'N/A'}'),
              Text('Address: ${shop['establishmentAddress'] ?? 'N/A'}'),
              Text('Grade: ${shop['grade'] ?? 'N/A'}'),
              Text('NIC Number: ${shop['nicNumber'] ?? 'N/A'}'),
              Text('Owner: ${shop['ownerName'] ?? 'N/A'}'),
              Text('Telephone: ${shop['telephone'] ?? 'N/A'}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/shop_detail', arguments: shop['id']);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F41BB),
                ),
                child: const Text('View Full Details'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Move to the next shop's location
  void _moveToNextShop() {
    if (_shops.isEmpty) return;
    setState(() {
      _currentShopIndex = (_currentShopIndex + 1) % _shops.length;
      final shop = _shops[_currentShopIndex];
      final location = shop['location'] as GeoPoint?;
      final lat = location?.latitude ?? _initialPosition.latitude;
      final lng = location?.longitude ?? _initialPosition.longitude;
      _mapController.move(LatLng(lat, lng), 16.0);
    });
  }

  // Move to the previous shop's location
  void _moveToPreviousShop() {
    if (_shops.isEmpty) return;
    setState(() {
      _currentShopIndex = (_currentShopIndex - 1 + _shops.length) % _shops.length;
      final shop = _shops[_currentShopIndex];
      final location = shop['location'] as GeoPoint?;
      final lat = location?.latitude ?? _initialPosition.latitude;
      final lng = location?.longitude ?? _initialPosition.longitude;
      _mapController.move(LatLng(lat, lng), 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      endDrawer: const SafeServeDrawer(
        profileImageUrl: '',
        userName: 'User Name',
        userPost: 'Health Inspector',
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _initialPosition,
              zoom: 14.0,
              minZoom: 3.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.safeserve.app',
              ),
              MarkerLayer(
                markers: _shops.map((shop) {
                  final location = shop['location'] as GeoPoint?;
                  final lat = location?.latitude ?? 0.0;
                  final lng = location?.longitude ?? 0.0;
                  if (lat == 0.0 || lng == 0.0) return null;
                  return Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(lat, lng),
                    builder: (ctx) => GestureDetector(
                      onTap: () => _showShopDetails(context, shop),
                      child: const Icon(
                        Icons.location_on,
                        color: Color(0xFF1F41BB),
                        size: 40,
                      ),
                    ),
                  );
                }).whereType<Marker>().toList(),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 260, // Adjusted to make room for new buttons
            child: Column(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.zoom_in, color: Color(0xFF1F41BB)),
                    onPressed: () {
                      final currentZoom = _mapController.zoom;
                      _mapController.move(_mapController.center, currentZoom + 1);
                    },
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.zoom_out, color: Color(0xFF1F41BB)),
                    onPressed: () {
                      final currentZoom = _mapController.zoom;
                      _mapController.move(_mapController.center, currentZoom - 1);
                    },
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F41BB),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.my_location, color: Colors.white),
                    onPressed: () {
                      _getCurrentLocation();
                    },
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F41BB),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_upward, color: Colors.white),
                    onPressed: _moveToPreviousShop,
                    tooltip: 'Previous Shop',
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F41BB),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    onPressed: _moveToNextShop,
                    tooltip: 'Next Shop',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomNavBarIcon(
                    icon: Icons.calendar_today,
                    label: 'Calendar',
                    navItem: NavItem.calendar,
                  ),
                  CustomNavBarIcon(
                    icon: Icons.store,
                    label: 'Shops',
                    navItem: NavItem.shops,
                  ),
                  CustomNavBarIcon(
                    icon: Icons.dashboard,
                    label: 'Dashboard',
                    navItem: NavItem.dashboard,
                  ),
                  CustomNavBarIcon(
                    icon: Icons.description,
                    label: 'Forms',
                    navItem: NavItem.form,
                  ),
                  CustomNavBarIcon(
                    icon: Icons.map,
                    label: 'Map',
                    navItem: NavItem.map,
                    selected: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getCurrentLocation() {
    _mapController.move(_initialPosition, 18);
  }
}