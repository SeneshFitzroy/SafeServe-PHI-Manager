import 'package:flutter/material.dart';
import 'package:safeserve/screens/register_shop/register_shop_form_data.dart';
import 'package:safeserve/screens/register_shop/screen_one/register_shop_screen_one.dart';
import 'package:safeserve/screens/register_shop/screen_two/register_shop_screen_two.dart';
import 'screens/registered_shops/registered_shops_screen.dart';
import 'screens/shop_detail/shop_detail_screen.dart';
import 'screens/h800_form/h800_form_screen.dart'; // Import H800FormScreen
import 'screens/h800_form/h800_form_screen_two.dart'; // Import H800FormScreenTwo
import 'screens/h800_form/h800_form_screen_three.dart'; // Import H800FormScreenThree
import 'screens/h800_form/h800_form_screen_four.dart'; // Import H800FormScreenFour
import 'screens/h800_form/h800_form_screen_five.dart'; // Import H800FormScreenFive
import 'screens/h800_form/h800_form_screen_six.dart'; // Import H800FormScreenSix
import 'screens/h800_form/h800_form_screen_seven.dart'; // Import H800FormScreenSeven
import 'screens/h800_form/h800_form_screen_eight.dart'; // Import H800FormScreenEight
import 'screens/h800_form/h800_form_screen_nine.dart'; // Import H800FormScreenNine
import 'screens/h800_form/h800_form_screen_ten.dart'; // Import H800FormScreenTen
import 'screens/h800_form/h800_form_summary.dart'; // Import H800FormSummary
import 'screens/h800_form/h800_form_data.dart'; // Import H800FormData
import 'screens/form_selection/form_selection_screen.dart'; // Import FormSelectionScreen

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
      // Start at the RegisteredShopsScreen
      home: const RegisteredShopsScreen(),

      // Placeholder for nav
      routes: {
        '/search': (context) => const PlaceholderPage(title: 'Search'),
        '/menu': (context) => const PlaceholderPage(title: 'Menu'),
        '/add': (context) => const PlaceholderPage(title: 'Add'),
        '/detail': (context) => const PlaceholderPage(title: 'Shop Detail'),
        '/calendar': (context) => const PlaceholderPage(title: 'Calendar'),
        '/dashboard': (context) => const PlaceholderPage(title: 'Dashboard'),
        '/form': (context) => const PlaceholderPage(title: 'Form'),
        '/notifications': (context) =>
            const PlaceholderPage(title: 'Notifications'),

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

        // Named route for H800FormScreenThree (Screen 3)
        '/h800_form_screen_three': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenThree(formData: formData ?? H800FormData());
        },

        // Route for H800FormScreenFour (Screen 4)
        '/h800_form_screen_four': (context) {
          final formData =
              ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenFour(formData: formData ?? H800FormData());
        },

        '/h800_form_screen_five': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenFive(formData: formData ?? H800FormData());
        },
        '/h800_form_screen_six': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenSix(formData: formData ?? H800FormData());
        },

        '/h800_form_screen_seven': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenSeven(formData: formData ?? H800FormData());
        },
        '/h800_form_screen_eight': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenEight(formData: formData ?? H800FormData());
        },
        '/h800_form_screen_nine': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenNine(formData: formData ?? H800FormData());
        },
        '/h800_form_screen_ten': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenTen(formData: formData ?? H800FormData());
        },


        // Route for H800FormSummary (Summary Screen)
        '/h800_form_summary': (context) {
          final formData =
              ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormSummary(formData: formData ?? H800FormData());
        },

        // New route for FormSelectionScreen
        '/form_selection': (context) {
          final formData =
              ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return FormSelectionScreen(formData: formData);
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
    );
  }
}
