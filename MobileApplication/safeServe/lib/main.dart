import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeserve/screens/notes/note_editor_screen.dart';
import 'package:safeserve/screens/notes/notes_list_screen.dart';
import 'package:safeserve/firebase_options.dart';
import 'package:safeserve/screens/login_screen/login_screen.dart';
import 'package:safeserve/screens/register_shop/register_shop_form_data.dart';
import 'package:safeserve/screens/register_shop/screen_one/register_shop_screen_one.dart';
import 'package:safeserve/screens/register_shop/screen_two/register_shop_screen_two.dart';
import 'package:safeserve/screens/shop_detail/shop_detail_screen.dart';
import 'package:safeserve/screens/h800_form/h800_form_data.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen.dart';
import 'package:safeserve/screens/h800_form/h800_form_screen_two.dart';
import 'package:safeserve/screens/view_shop_detail/view_shop_detail_screen.dart';
import 'package:safeserve/screens/edit_shop_detail/edit_shop_detail_screen.dart';
import 'package:safeserve/screens/Reports_Analytics.dart/Reports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const SafeServeApp());
}

class SafeServeApp extends StatelessWidget {
  const SafeServeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeServe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const LoginScreen(),
      routes: {
        '/search': (_) => const _PlaceholderPage(title: 'Search'),
        '/menu': (_) => const _PlaceholderPage(title: 'Menu'),
        '/add': (_) => const _PlaceholderPage(title: 'Add'),
        '/detail': (_) => const _PlaceholderPage(title: 'Shop Detail'),
        '/calendar': (_) => const _PlaceholderPage(title: 'Calendar'),
        '/dashboard': (_) => const _PlaceholderPage(title: 'Dashboard'),
        '/form': (_) => const _PlaceholderPage(title: 'Form'),
        '/notes': (_) => const NotesListScreen(),
        '/note_edit': (ctx) {
          final id = ModalRoute.of(ctx)!.settings.arguments as String?;
          return NoteEditScreen(noteId: id);
        },
        '/register_shop_screen_one': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as RegisterShopFormData?;
          return RegisterShopScreenOne(formData: formData ?? RegisterShopFormData());
        },
        '/register_shop_screen_two': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as RegisterShopFormData?;
          return RegisterShopScreenTwo(formData: formData ?? RegisterShopFormData());
        },
        '/shop_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return ShopDetailScreen(shopId: args ?? '');
        },
        '/h800_form_screen': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreen(
            formData: formData ?? H800FormData(),
            shopId: '',
            phiId: '',
          );
        },
        '/h800_form_screen_two': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as H800FormData?;
          return H800FormScreenTwo(
            formData: formData ?? H800FormData(),
            shopId: '',
            phiId: '',
          );
        },
        '/reports': (_) => const Reports(), // Added route for Reports page
      },
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 20))),
    );
  }
}