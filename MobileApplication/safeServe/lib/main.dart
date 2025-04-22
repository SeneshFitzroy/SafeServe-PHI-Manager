import 'package:flutter/material.dart';
import 'package:safeserve/screens/register_shop/register_shop_form_data.dart';
import 'package:safeserve/screens/register_shop/screen_one/register_shop_screen_one.dart';
import 'package:safeserve/screens/register_shop/screen_two/register_shop_screen_two.dart';
import 'package:safeserve/widgets/custom_nav_bar_icon.dart';
import 'screens/registered_shops/registered_shops_screen.dart';
import 'screens/shop_detail/shop_detail_screen.dart';
import 'screens/h800_form/h800_form_screen.dart'; // Import H800FormScreen
import 'screens/h800_form/h800_form_screen_two.dart'; // Import H800FormScreenTwo
import 'screens/h800_form/h800_form_data.dart'; // Import H800FormData
import 'screens/form_selection/form_selection_screen.dart'; // Import FormSelectionScreen
import 'screens/NotificationsPage/notifications_screen.dart'; // Import NotificationsScreen
import 'widgets/safe_serve_bottom_nav.dart'; // Import SafeServeBottomNav

void main() {
  runApp(const SafeServeApp());
}

class SafeServeApp extends StatelessWidget {
  const SafeServeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeServe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // Use initialRoute instead of home
      initialRoute: '/',
      routes: {
        '/': (context) => const RegisteredShopsScreen(),
        '/search': (context) => const PlaceholderPage(title: 'Search'),
        '/menu': (context) => const PlaceholderPage(title: 'Menu'),
        '/add': (context) => const PlaceholderPage(title: 'Add'),
        '/detail': (context) => const PlaceholderPage(title: 'Shop Detail'),
        '/calendar': (context) => const PlaceholderPage(title: 'Calendar'),
        '/dashboard': (context) => const PlaceholderPage(title: 'Dashboard'),
        '/form': (context) => const PlaceholderPage(title: 'Form'),
        '/notifications': (context) => const NotificationsScreen(),
        '/register_shop_screen_one': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments
              as RegisterShopFormData?;
          return RegisterShopScreenOne(
              formData: formData ?? RegisterShopFormData());
        },
        '/register_shop_screen_two': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments
              as RegisterShopFormData?;
          return RegisterShopScreenTwo(
              formData: formData ?? RegisterShopFormData());
        },

        // Named route for ShopDetailScreen
        '/shop_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return ShopDetailScreen(shopId: args ?? '');
        },

        // Named route for H800FormScreen
        '/h800_form_screen': (context) {
          final formData =
              ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreen(formData: formData ?? H800FormData());
        },

        // Placeholder route for H800FormScreenTwo (to be implemented later)
        '/h800_form_screen_two': (context) {
          final formData =
              ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenTwo(formData: formData ?? H800FormData());
        },

        // New route for FormSelectionScreen
        '/form_selection': (context) {
          final formData =
              ModalRoute.of(context)?.settings.arguments as H800FormData?;
          // Pass the map data to the FormSelectionScreen
          return FormSelectionScreen(data: formData?.toMap() ?? {});
        },
      },
    );
  }
}

// placeholder page for routes not yet implemented
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 20))),
      // Add bottom navigation bar to placeholder pages for consistency
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 38, left: 35, right: 35),
        height: 98,
        child: Container(
          width: 318,
          height: 60,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomNavBarIcon(
                icon: Icons.home_outlined,
                label: 'Home',
                route: '/',
                selected: false,
              ),
              CustomNavBarIcon(
                icon: Icons.calendar_today_outlined,
                label: 'Calendar',
                route: '/calendar',
                selected: title == 'Calendar',
              ),
              CustomNavBarIcon(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                route: '/notifications',
                selected: false,
              ),
              CustomNavBarIcon(
                icon: Icons.person_outline,
                label: 'Profile',
                route: '/profile',
                selected: title == 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
