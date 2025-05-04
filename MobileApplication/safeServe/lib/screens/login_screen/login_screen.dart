import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../registered_shops/registered_shops_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _pwdCtrl   = TextEditingController();
  bool  _obscure   = true;
  bool  _loading   = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => _loading = true);
    final msg = await AuthService.instance.login(
      email: _emailCtrl.text,
      password: _pwdCtrl.text,
    );
    setState(() => _loading = false);

    if (msg != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg)));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const RegisteredShopsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/other/logo.png',
                      width: 100, height: 100),
                  const SizedBox(height: 25),
                  const Text('Welcome Back',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Enter your username and password to log in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF696E72))),
                  const SizedBox(height: 20),

                  // Email
                  _label('Email'),
                  _rounded(
                    child: TextField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _hint('Enter your email'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password
                  _label('Password'),
                  _rounded(
                    child: TextField(
                      controller: _pwdCtrl,
                      obscureText: _obscure,
                      decoration: _hint('Enter your password').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () =>
                              setState(() => _obscure = !_obscure),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F41BB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _loading ? null : _handleLogin,
                      child: _loading
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 3, color: Colors.white),
                      )
                          : const Text('Login',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Align(
    alignment: Alignment.centerLeft,
    child: Text(t,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF696E72),
        )),
  );

  Widget _rounded({required Widget child}) => Container(
    decoration: BoxDecoration(
      color: const Color(0xFFCDE6FE),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFABD3FA)),
    ),
    child: child,
  );

  InputDecoration _hint(String t) => InputDecoration(
    hintText: t,
    hintStyle: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      color: Colors.black54,
    ),
    border: InputBorder.none,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}