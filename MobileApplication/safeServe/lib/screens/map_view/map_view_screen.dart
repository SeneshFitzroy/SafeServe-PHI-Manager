import 'package:flutter/material.dart';
import '../../widgets/safe_serve_drawer.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      drawer: SafeServeDrawer(
        profileImageUrl: '',
        userName: 'User Name',
        userPost: 'Inspector',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map, size: 80, color: Color(0xFF1F41BB)),
            const SizedBox(height: 16),
            const Text(
              'Map View',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Location tracking and visualization',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
