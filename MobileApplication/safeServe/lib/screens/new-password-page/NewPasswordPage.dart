import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _validatePassword() {
    if (_passwordController.text.isEmpty) {
      setState(() => _passwordError = "Password cannot be empty");
      return false;
    } else if (_passwordController.text.length < 8) {
      setState(() => _passwordError = "Password must be at least 8 characters");
      return false;
    } else {
      setState(() => _passwordError = null);
      return true;
    }
  }

  bool _validateConfirmPassword() {
    if (_confirmPasswordController.text != _passwordController.text) {
      setState(() => _confirmPasswordError = "Passwords don't match");
      return false;
    } else {
      setState(() => _confirmPasswordError = null);
      return true;
    }
  }

  void _setNewPassword() {
    if (_validatePassword() && _validateConfirmPassword()) {
      // Implement password setting logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );
      // Navigate back or to next screen
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 78,
                        top: 44,
                        child: Text(
                          'SafeServe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF1F41BB),
                            fontSize: 25,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Logo and buttons positions kept from design
                    ],
                  ),
                ),
                
                // Back Button
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFCDE6FE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                    ),
                  ),
                ),
                
                // Page Title
                const SizedBox(height: 40),
                Text(
                  'New Password',
                  style: TextStyle(
                    color: const Color(0xFF1F41BB),
                    fontSize: 35,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                
                const SizedBox(height: 15),
                const Text(
                  'Set your new password',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                
                // Password Field
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Color(0xFF4289FC)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Color(0xFF4289FC)),
                          ),
                          errorText: _passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                        onChanged: (_) => _validatePassword(),
                      ),
                      
                      // Confirm Password Field
                      const SizedBox(height: 30),
                      const Text(
                        'Confirm New Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Color(0xFF4289FC)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Color(0xFF4289FC)),
                          ),
                          errorText: _confirmPasswordError,
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                          ),
                        ),
                        onChanged: (_) => _validateConfirmPassword(),
                      ),
                      
                      // Submit Button
                      const SizedBox(height: 55),
                      ElevatedButton(
                        onPressed: _setNewPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F41BB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(341, 55),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Set New Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
