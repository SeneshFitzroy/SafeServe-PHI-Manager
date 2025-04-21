import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/safe_serve_drawer.dart';
import '../../widgets/custom_nav_bar_icon.dart';
import 'dart:async';
import '../registered_shops/registered_shops_screen.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Controller for the Google Map
  final Completer<GoogleMapController> _controllerCompleter = Completer();
  GoogleMapController? _mapController;
  
  // Initial camera position centered on Sri Lanka
  static const LatLng _sriLankaCenter = LatLng(7.8731, 80.7718);
  
  // Initial map configuration
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: _sriLankaCenter,
    zoom: 8.0,
  );
  
  // Set of map markers
  final Set<Marker> _markers = {};
  
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  // Method to add a sample marker
  void _addSampleMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('colombo'),
          position: const LatLng(6.9271, 79.8612), // Colombo coordinates
          infoWindow: const InfoWindow(title: 'Colombo', snippet: 'Capital of Sri Lanka'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeServeAppBar(
        height: 100,
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: const SafeServeDrawer(
        profileImageUrl: '', // Replace with actual profile URL
        userName: 'John Doe', // Replace with actual user name
        userPost: 'Health Inspector', // Replace with actual user post
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.5, 0),
            end: Alignment(0.5, 1),
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(34, 30, 0, 20),
              child: Row(
                children: [
                  // Back button - Updated to navigate to RegisteredShopsScreen
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisteredShopsScreen()),
                      );
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFCDE6FE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF1F41BB),
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFCDE6FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Icon(
                      Icons.map,
                      color: Color(0xFF1F41BB),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Map View',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 34),
                    child: FloatingActionButton.small(
                      backgroundColor: const Color(0xFFCDE6FE),
                      foregroundColor: const Color(0xFF1F41BB),
                      elevation: 2,
                      onPressed: _addSampleMarker,
                      child: const Icon(Icons.add_location_alt_outlined),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: _initialCameraPosition,
                      markers: _markers,
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      compassEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controllerCompleter.complete(controller);
                        _mapController = controller;
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF1F41BB),
          onPressed: () async {
            final GoogleMapController controller = await _controllerCompleter.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition),
            );
          },
          child: const Icon(Icons.my_location, color: Colors.white),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 47, right: 47, bottom: 40),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
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
              label: 'Form',
              navItem: NavItem.form,
            ),
            CustomNavBarIcon(
              icon: Icons.notifications,
              label: 'Notifications',
              navItem: NavItem.notifications,
            ),
            // Removed the Map icon from here
          ],
        ),
      ),
    );
  }
}
