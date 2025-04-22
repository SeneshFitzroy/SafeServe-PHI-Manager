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
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey            = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _isLoading       = false;
  String? _errorMsg;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // dismiss keyboard
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMsg  = null;
    });

    try {
      // <<-- THE ACTUAL SIGN-IN CALL
      await AuthService.instance.signIn(
        email:    _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;
      // Success: go to your main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisteredShopsScreen()),
      );
    } on AuthException catch (e) {
      setState(() => _errorMsg = e.message);
    } catch (e, st) {
      // should never happen, but just in case
      // ignore: avoid_print
      print('Unexpected login error: $e\n$st');
      setState(() => _errorMsg = 'Unexpected error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/other/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your username and password to log in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF696E72),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // EMAIL LABEL + FIELD
                    _label('Email'),
                    _inputWrapper(
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => (v != null && v.contains('@'))
                            ? null
                            : 'Invalid email address',
                        decoration: _inputDeco('Enter your email'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // PASSWORD LABEL + FIELD
                    _label('Password'),
                    _inputWrapper(
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: (v) => (v != null && v.length >= 6)
                            ? null
                            : 'Min 6 characters',
                        decoration: _inputDeco('Enter your password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => setState(() {
                              _obscurePassword = !_obscurePassword;
                            }),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ERROR MESSAGE, if any
                    if (_errorMsg != null) ...[
                      Text(_errorMsg!,
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 12),
                    ],

                    // LOGIN BUTTON
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
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ————— Helpers —————

  Widget _label(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Color(0xFF696E72),
      ),
    ),
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
