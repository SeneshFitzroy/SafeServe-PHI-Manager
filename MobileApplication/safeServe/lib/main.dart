import 'package:flutter/material.dart';
import 'package:safeserve/screens/login_screen/login_screen.dart';
import 'package:safeserve/screens/register_shop/register_shop_form_data.dart';
import 'package:safeserve/screens/register_shop/screen_one/register_shop_screen_one.dart';
import 'package:safeserve/screens/register_shop/screen_two/register_shop_screen_two.dart';
import 'package:safeserve/screens/shop_detail/shop_detail_screen.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_two.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_three.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_four.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_five.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_six.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_seven.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_eight.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_nine.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_ten.dart';
import 'package:safeserve/screens/h800_form/h800_form_summary.dart';
import 'package:safeserve/screens/h800_form/h800_form_data.dart';
import 'package:safeserve/screens/view_shop_detail/view_shop_detail_screen.dart';
import 'package:safeserve/screens/edit_shop_detail/edit_shop_detail_screen.dart';

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
      home: const LoginScreen(),
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
        '/shop_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return ShopDetailScreen(shopId: args ?? '');
        },
        '/h800_form_screen': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreen(formData: formData ?? H800FormData());
        },
        '/h800_form_screen_two': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenTwo(formData: formData ?? H800FormData());
        },
         '/h800_form_screen_three': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenThree(formData: formData ?? H800FormData());
        },
         '/h800_form_screen_four': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenFour(formData: formData ?? H800FormData());
        },
         '/h800_form_screen_five': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenFive(formData: formData ?? H800FormData());
        },
         '/h800_form_screen_six': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenSix(formData: formData ?? H800FormData());
        },
         '/h800_form_screen_seven': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenSeven(formData: formData ?? H800FormData());
        },
         '/h800_form_screen_eight': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenEight(formData: formData ?? H800FormData());
        },
         '/h800_form_screen_nine': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenNine(formData: formData ?? H800FormData());
        },
         '/h800_form_screen_ten': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenTen(formData: formData ?? H800FormData());
        },
         '/h800_form_summary': (context) {
          final formData =
          ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormSummary(formData: formData ?? H800FormData());
        },
        '/view_shop_detail': (context) => const ViewShopDetailScreen(),
        '/edit_shop_detail': (context) => const EditShopDetailScreen(),
      },
    );
  }
}

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
