import 'package:flutter/material.dart';

class MapViewPage extends StatelessWidget {
  const MapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          RectangleCard(title: 'Rectangle Card 1'),
          RectangleCard(title: 'Rectangle Card 2'),
        ],
      ),
    );
  }
}

class RectangleCard extends StatelessWidget {
  final String title;

  const RectangleCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 318,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
