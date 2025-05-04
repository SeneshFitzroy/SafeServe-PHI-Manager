import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';       // ← new
import 'package:safeserve/screens/notes/note_editor_screen.dart';
import 'firebase_options.dart';

import 'screens/login_screen/login_screen.dart';
import 'screens/register_shop/register_shop_form_data.dart';
import 'screens/register_shop/screen_one/register_shop_screen_one.dart';
import 'screens/register_shop/screen_two/register_shop_screen_two.dart';
import 'screens/shop_detail/shop_detail_screen.dart';
import 'screens/h800_form/h800_form_data.dart';
import 'screens/h800_form/h800_form_screen.dart';
import 'screens/h800_form/h800_form_screen_two.dart';
import 'screens/view_shop_detail/view_shop_detail_screen.dart';
import 'screens/edit_shop_detail/edit_shop_detail_screen.dart';
import 'screens/notes/notes_list_screen.dart';                // ← added

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ENABLE OFFLINE PERSISTENCE for Firestore:
  // (on mobile it's on by default, but this makes it explicit
  //  and unlimits the cache size)
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
        '/menu':   (_) => const _PlaceholderPage(title: 'Menu'),
        '/add':    (_) => const _PlaceholderPage(title: 'Add'),
        '/detail': (_) => const _PlaceholderPage(title: 'Shop Detail'),
        '/calendar':      (_) => const _PlaceholderPage(title: 'Calendar'),
        '/dashboard':     (_) => const _PlaceholderPage(title: 'Dashboard'),
        '/form':          (_) => const _PlaceholderPage(title: 'Form'),
        '/notes': (_) => const NotesListScreen(),
        '/note_edit': (ctx) {
        final id = ModalRoute.of(ctx)!.settings.arguments as String?;
        return NoteEditScreen(noteId: id);
        },
        // Notes

        // Register Shop
        '/register_shop_screen_one': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments
          as RegisterShopFormData?;
          return RegisterShopScreenOne(
            formData: args ?? RegisterShopFormData(),
          );
        },
        '/register_shop_screen_two': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments
          as RegisterShopFormData?;
          return RegisterShopScreenTwo(
            formData: args ?? RegisterShopFormData(),
          );
        },

        // Shop Detail
        '/shop_detail': (ctx) {
          final shopId = ModalRoute.of(ctx)!.settings.arguments as String?;
          return ShopDetailScreen(shopId: shopId ?? '');
        },

        // HC800 Form Flow
        '/h800_form_screen': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments
          as H800FormData?;
          return H800FormScreen(
            formData: args ?? H800FormData(),
          );
        },
        '/h800_form_screen_two': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments
          as H800FormData?;
          return H800FormScreenTwo(
            formData: args ?? H800FormData(),
          );
        },

        // View & Edit Shop Detail
        '/view_shop_detail': (_) => const ViewShopDetailScreen(),
        '/edit_shop_detail': (_) => const EditShopDetailScreen(),
      },
    );
  }
}

/// A tiny placeholder page to stub out unimplemented routes.
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 20))),
    );
  }
}
