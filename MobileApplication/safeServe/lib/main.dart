// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/registered_shops/registered_shops_screen.dart';
import 'screens/shop_detail/shop_detail_screen.dart';

void main() {
  runApp(const SafeServeApp());
}

class SafeServeApp extends StatelessWidget {
  const SafeServeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeServe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Uses default Roboto font on Android
        fontFamily: 'Roboto',
      ),
      // Start at the RegisteredShopsScreen
      home: const RegisteredShopsScreen(),

      // Placeholder or real routes
      routes: {
        '/search': (context) => const PlaceholderPage(title: 'Search'),
        '/menu': (context) => const PlaceholderPage(title: 'Menu'),
        '/filter': (context) => const PlaceholderPage(title: 'Filter'),
        '/add': (context) => const PlaceholderPage(title: 'Add'),
        '/detail': (context) => const PlaceholderPage(title: 'Shop Detail'),
        '/calendar': (context) => const PlaceholderPage(title: 'Calendar'),
        '/dashboard': (context) => const PlaceholderPage(title: 'Dashboard'),
        '/form': (context) => const PlaceholderPage(title: 'Form'),
        '/notifications': (context) => const PlaceholderPage(title: 'Notifications'),

        // Named route for ShopDetailScreen (example):
        '/shop_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return ShopDetailScreen(shopId: args ?? '');
        },
      },
    );
  }
}

// Just a placeholder page for routes not yet implemented
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 20))),
    );
  }
}
