// lib/screens/login_screen/login_screen.dart
import 'package:flutter/material.dart';
import '../registered_shops/registered_shops_screen.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl    = TextEditingController();
  final _passCtrl     = TextEditingController();
  final _formKey      = GlobalKey<FormState>();

  bool _hidePass   = true;
  bool _loading    = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error   = null;
    });

    try {
      await AuthService.instance
          .signIn(email: _emailCtrl.text, password: _passCtrl.text);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisteredShopsScreen()),
      );
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 340,
            padding:
            const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Image.asset('assets/images/other/logo.png',
                    width: 100, height: 100),
                const SizedBox(height: 25),
                const Text('Welcome Back',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                  'Enter your username and password to log in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF696E72)),
                ),
                const SizedBox(height: 20),

                // Email
                _label('Email'),
                _inputWrapper(
                  child: TextFormField(
                    controller: _emailCtrl,
                    validator: (v) =>
                    v != null && v.contains('@') ? null : 'Invalid e‑mail',
                    decoration: _inputDeco('Enter your email'),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                _label('Password'),
                _inputWrapper(
                  child: TextFormField(
                    controller: _passCtrl,
                    obscureText: _hidePass,
                    validator: (v) =>
                    v != null && v.length >= 6 ? null : 'Min 6 chars',
                    decoration: _inputDeco('Enter your password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                            _hidePass ? Icons.visibility_off : Icons.visibility),
                        onPressed: () =>
                            setState(() => _hidePass = !_hidePass),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                if (_error != null) ...[
                  Text(_error!,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                ],

                // Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F41BB),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                      const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _loading ? null : _login,
                    child: _loading
                        ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                        : const Text('Login',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    ),
  );

  // ---------- small helpers ----------
  Widget _label(String txt) => Align(
    alignment: Alignment.centerLeft,
    child: Text(txt,
        style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF696E72))),
  );

  Widget _inputWrapper({required Widget child}) => Container(
    decoration: BoxDecoration(
      color: const Color(0xFFCDE6FE),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFABD3FA)),
    ),
    child: child,
  );

  InputDecoration _inputDeco(String hint) => InputDecoration(
    hintText: hint,
    border: InputBorder.none,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}
