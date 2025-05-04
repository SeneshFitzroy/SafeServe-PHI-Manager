// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
import 'package:safeserve/screens/Profileview/profile.dart';
import 'package:safeserve/screens/form_selection/form_selection_screen.dart';
import 'package:safeserve/screens/notes/note_editor_screen.dart';
=======
import 'package:safeserve/screens/dashboard/dashboard_screen.dart';

// ─── Firebase & project options ────────────────────────────────────────────────
>>>>>>> 151f3e602c2476462654d04fd16c5fc1654e7d0d
import 'firebase_options.dart';

// ─── Auth (needed later for OTP / form upload) ────────────────────────────────
import 'package:firebase_auth/firebase_auth.dart';

// ─── Core screens already in the project ──────────────────────────────────────
import 'screens/login_screen/login_screen.dart';
import 'screens/register_shop/register_shop_form_data.dart';
import 'screens/register_shop/screen_one/register_shop_screen_one.dart';
import 'screens/register_shop/screen_two/register_shop_screen_two.dart';
import 'screens/shop_detail/shop_detail_screen.dart';
import 'screens/view_shop_detail/view_shop_detail_screen.dart';
import 'screens/edit_shop_detail/edit_shop_detail_screen.dart';
import 'screens/notes/notes_list_screen.dart';
<<<<<<< HEAD
=======
import 'screens/notes/note_editor_screen.dart';

// ─── HC‑800 wizard –– 10 steps + final screens ────────────────────────────────
import 'screens/h800_form/h800_form_screen.dart';
import 'screens/h800_form/h800_form_screen_two.dart';
import 'screens/h800_form/h800_form_screen_three.dart';
import 'screens/h800_form/h800_form_screen_four.dart';
import 'screens/h800_form/h800_form_screen_five.dart';
import 'screens/h800_form/h800_form_screen_six.dart';
import 'screens/h800_form/h800_form_screen_seven.dart';
import 'screens/h800_form/h800_form_screen_eight.dart';
import 'screens/h800_form/h800_form_screen_nine.dart';
import 'screens/h800_form/h800_form_screen_ten.dart';
import 'screens/h800_form/success_screen.dart';



// ─── Pin‑code‑fields TextTheme shim for Flutter 3.13+ ─────────────────────────
extension TextThemeButtonShim on TextTheme {
  TextStyle? get button => labelLarge;
}
>>>>>>> 151f3e602c2476462654d04fd16c5fc1654e7d0d

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

<<<<<<< HEAD
=======
  // Firestore: explicit unlimited cache / offline persistence
>>>>>>> 151f3e602c2476462654d04fd16c5fc1654e7d0d
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const SafeServeApp());
}

class SafeServeApp extends StatelessWidget {
  const SafeServeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeServe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
<<<<<<< HEAD
      home: const LoginScreen(), // Revert to LoginScreen for normal authentication flow
      routes: {
        '/search': (_) => const _PlaceholderPage(title: 'Search'),
        '/menu': (_) => const _PlaceholderPage(title: 'Menu'),
        '/add': (_) => const _PlaceholderPage(title: 'Add'),
        '/detail': (_) => const _PlaceholderPage(title: 'Shop Detail'),
        '/calendar': (_) => const _PlaceholderPage(title: 'Calendar'),
        '/dashboard': (_) => const _PlaceholderPage(title: 'Dashboard'),
        '/form': (_) => const _PlaceholderPage(title: 'Form'),
        '/notes': (_) => const NotesListScreen(),
=======
      home: const LoginScreen(),

      // ──────────────────────────────────────────────────────────────────
      // Named routes (hot‑reload friendly)
      // ──────────────────────────────────────────────────────────────────
      routes: {
        // Generic stub pages
        '/search':   (_) => const _PlaceholderPage(title: 'Search'),
        '/menu':     (_) => const _PlaceholderPage(title: 'Menu'),
        '/add':      (_) => const _PlaceholderPage(title: 'Add'),
        '/detail':   (_) => const _PlaceholderPage(title: 'Shop Detail'),
        '/calendar': (_) => const _PlaceholderPage(title: 'Calendar'),
        '/form':     (_) => const _PlaceholderPage(title: 'Form'),

        // Notes
        '/notes':     (_) => const NotesListScreen(),
>>>>>>> 151f3e602c2476462654d04fd16c5fc1654e7d0d
        '/note_edit': (ctx) {
          final id = ModalRoute.of(ctx)!.settings.arguments as String?;
          return NoteEditScreen(noteId: id);
        },
<<<<<<< HEAD
=======

        // Register‑shop wizard
>>>>>>> 151f3e602c2476462654d04fd16c5fc1654e7d0d
        '/register_shop_screen_one': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments as RegisterShopFormData?;
          return RegisterShopScreenOne(
            formData: args ?? RegisterShopFormData(),
          );
        },
        '/register_shop_screen_two': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments as RegisterShopFormData?;
          return RegisterShopScreenTwo(
            formData: args ?? RegisterShopFormData(),
          );
        },
<<<<<<< HEAD
=======

        // Shop detail
>>>>>>> 151f3e602c2476462654d04fd16c5fc1654e7d0d
        '/shop_detail': (ctx) {
          final shopId = ModalRoute.of(ctx)!.settings.arguments as String?;
          return ShopDetailScreen(shopId: shopId ?? '');
        },
<<<<<<< HEAD
        '/h800_form_screen': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments as H800FormData?;
          return H800FormScreen(
            formData: args ?? H800FormData(),
          );
        },
        '/h800_form_screen_two': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments as H800FormData?;
          return H800FormScreenTwo(
            formData: args ?? H800FormData(),
          );
        },
        '/form_selection': (context) {
          final formData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return FormSelectionScreen(formData: formData ?? {});
        },
=======

        // HC‑800 10‑step wizard
        '/h800_form_screen_one':   (ctx) => _h800Builder(ctx, 1),
        '/h800_form_screen_two':   (ctx) => _h800Builder(ctx, 2),
        '/h800_form_screen_three': (ctx) => _h800Builder(ctx, 3),
        '/h800_form_screen_four':  (ctx) => _h800Builder(ctx, 4),
        '/h800_form_screen_five':  (ctx) => _h800Builder(ctx, 5),
        '/h800_form_screen_six':   (ctx) => _h800Builder(ctx, 6),
        '/h800_form_screen_seven': (ctx) => _h800Builder(ctx, 7),
        '/h800_form_screen_eight': (ctx) => _h800Builder(ctx, 8),
        '/h800_form_screen_nine':  (ctx) => _h800Builder(ctx, 9),
        '/h800_form_screen_ten':   (ctx) => _h800Builder(ctx, 10),

        // After form submission (swap placeholders later)
        '/h800_photo_upload': (_) => const _PlaceholderPage(title: 'Photo'),
        '/h800_score':        (_) => const _PlaceholderPage(title: 'Score'),
        '/h800_owner_otp':    (_) => const _PlaceholderPage(title: 'OTP'),
        '/h800_success':      (_) => const H800SuccessScreen(),

        // View / edit shop detail
>>>>>>> 151f3e602c2476462654d04fd16c5fc1654e7d0d
        '/view_shop_detail': (_) => const ViewShopDetailScreen(),
        '/edit_shop_detail': (_) => const EditShopDetailScreen(),

        '/dashboard': (_) => const DashboardScreen(),
      },
    );
  }

<<<<<<< HEAD
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'SafeServe Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate if needed
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text('Notes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/notes');
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 20))),
    );
  }
}
=======
  /// Helper to pull the common args for every HC‑800 step
  Widget _h800Builder(BuildContext ctx, int step) {
    final m = ModalRoute.of(ctx)!.settings.arguments as Map;
    final formData = m['formData'];
    final shopId   = m['shopId'];
    final phiId    = m['phiId'];
    switch (step) {
      case 1:  return H800FormScreen(formData: formData,   shopId: shopId, phiId: phiId);
      case 2:  return H800FormScreenTwo(formData: formData,shopId: shopId, phiId: phiId);
      case 3:  return H800FormScreenThree(formData: formData,shopId: shopId, phiId: phiId);
      case 4:  return H800FormScreenFour(formData: formData,shopId: shopId, phiId: phiId);
      case 5:  return H800FormScreenFive(formData: formData,shopId: shopId, phiId: phiId);
      case 6:  return H800FormScreenSix(formData: formData, shopId: shopId, phiId: phiId);
      case 7:  return H800FormScreenSeven(formData: formData,shopId: shopId, phiId: phiId);
      case 8:  return H800FormScreenEight(formData: formData,shopId: shopId, phiId: phiId);
      case 9:  return H800FormScreenNine(formData: formData, shopId: shopId, phiId: phiId);
      case 10: return H800FormScreenTen(formData: formData, shopId: shopId, phiId: phiId);
      default: return const _PlaceholderPage(title: 'HC‑800');
    }
  }
}

/// Tiny stub for routes that aren’t built yet
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(
      child: Text(title, style: const TextStyle(fontSize: 20)),
    ),
  );
}
>>>>>>> 151f3e602c2476462654d04fd16c5fc1654e7d0d
