import 'package:flutter/material.dart';
import 'package:safeserve/widgets/safe_serve_drawer.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
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
            const Icon(Icons.assessment, size: 80, color: Color(0xFF1F41BB)),
            const SizedBox(height: 16),
            const Text(
              'Reports',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'View and generate inspection reports',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
