import 'package:flutter/material.dart';
import 'dart:async';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // Controllers for each OTP digit
  final TextEditingController _firstDigitController = TextEditingController();
  final TextEditingController _secondDigitController = TextEditingController();
  final TextEditingController _thirdDigitController = TextEditingController();
  final TextEditingController _fourthDigitController = TextEditingController();
  
  // Focus nodes for each input field
  final FocusNode _firstDigitFocus = FocusNode();
  final FocusNode _secondDigitFocus = FocusNode();
  final FocusNode _thirdDigitFocus = FocusNode();
  final FocusNode _fourthDigitFocus = FocusNode();
  
  // Timer for countdown
  Timer? _timer;
  int _remainingSeconds = 120;
  
  @override
  void initState() {
    super.initState();
    _startTimer();
    
    // Add listeners to automatically move focus to next field
    _firstDigitController.addListener(() {
      if (_firstDigitController.text.length == 1) {
        FocusScope.of(context).requestFocus(_secondDigitFocus);
      }
    });
    
    _secondDigitController.addListener(() {
      if (_secondDigitController.text.length == 1) {
        FocusScope.of(context).requestFocus(_thirdDigitFocus);
      }
    });
    
    _thirdDigitController.addListener(() {
      if (_thirdDigitController.text.length == 1) {
        FocusScope.of(context).requestFocus(_fourthDigitFocus);
      }
    });
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _firstDigitController.dispose();
    _secondDigitController.dispose();
    _thirdDigitController.dispose();
    _fourthDigitController.dispose();
    _firstDigitFocus.dispose();
    _secondDigitFocus.dispose();
    _thirdDigitFocus.dispose();
    _fourthDigitFocus.dispose();
    super.dispose();
  }
  
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }
  
  void _resendCode() {
    // Implement code resend logic here
    setState(() {
      _remainingSeconds = 120;
      // Clear the input fields
      _firstDigitController.clear();
      _secondDigitController.clear();
      _thirdDigitController.clear();
      _fourthDigitController.clear();
      // Focus on first field
      FocusScope.of(context).requestFocus(_firstDigitFocus);
    });
    
    // Restart timer
    _timer?.cancel();
    _startTimer();
    
    // Show a snackbar to confirm code was resent
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification code has been resent to your email'),
        backgroundColor: Color(0xFF1F41BB),
      ),
    );
  }
  
  String _getCompleteCode() {
    return _firstDigitController.text + 
           _secondDigitController.text + 
           _thirdDigitController.text + 
           _fourthDigitController.text;
  }
  
  void _verifyCode() {
    final code = _getCompleteCode();
    
    if (code.length < 4) {
      // Show error if code is incomplete
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 4 digits of the verification code'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // TODO: Implement actual verification logic
    // For now we'll just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification successful! Redirecting to password reset...'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Navigate to next screen after verification
    Future.delayed(const Duration(seconds: 2), () {
      // TODO: Navigate to password reset screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => NewPasswordScreen()));
    });
  }
  
  String _formatTimeRemaining() {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // App Bar
              _buildAppBar(),
              
              // Back Button
              Padding(
                padding: const EdgeInsets.only(left: 27, top: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFCDE6FE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Color(0xFF1F41BB),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Reset Code Title
              const SizedBox(height: 45),
              const Text(
                'Reset Code',
                style: TextStyle(
                  color: Color(0xFF1F41BB),
                  fontSize: 35,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                ),
              ),
              
              // Instruction Text
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 46),
                child: Text(
                  'We\'ve sent a password reset OTP to your registered email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              
              // OTP Input Fields
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildOtpTextField(_firstDigitController, _firstDigitFocus),
                    _buildOtpTextField(_secondDigitController, _secondDigitFocus),
                    _buildOtpTextField(_thirdDigitController, _thirdDigitFocus),
                    _buildOtpTextField(_fourthDigitController, _fourthDigitFocus),
                  ],
                ),
              ),
              
              // Verify Button
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _verifyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F41BB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Didn't get code text
              const SizedBox(height: 35),
              GestureDetector(
                onTap: _remainingSeconds == 0 ? _resendCode : null,
                child: Text(
                  'Didn\'t get code',
                  style: TextStyle(
                    color: _remainingSeconds == 0 ? const Color(0xFF1F41BB) : Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    decoration: _remainingSeconds == 0 ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ),
              
              // Expiration text
              const SizedBox(height: 15),
              Text(
                'Expire in ${_formatTimeRemaining()}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildAppBar() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 78,
            top: 44,
            child: Text(
              'SafeServe',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1F41BB),
                fontSize: 25,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            left: 33,
            top: 35,
            child: Container(
              width: 36,
              height: 38,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/36x38"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            right: 78,
            top: 41,
            child: Container(
              width: 35,
              height: 35,
              decoration: ShapeDecoration(
                color: const Color(0xFFCDE6FE),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xFFCDE6FE),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Icon(Icons.notifications_none, size: 20, color: Color(0xFF1F41BB)),
            ),
          ),
          Positioned(
            right: 28,
            top: 41,
            child: Container(
              width: 35,
              height: 35,
              decoration: ShapeDecoration(
                color: const Color(0xFFCDE6FE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Icon(Icons.person, size: 20, color: Color(0xFF1F41BB)),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOtpTextField(TextEditingController controller, FocusNode focusNode) {
    return Container(
      width: 66,
      height: 57,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFF4289FC),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          // Handle backspace
          if (value.isEmpty) {
            if (focusNode == _secondDigitFocus) {
              FocusScope.of(context).requestFocus(_firstDigitFocus);
            } else if (focusNode == _thirdDigitFocus) {
              FocusScope.of(context).requestFocus(_secondDigitFocus);
            } else if (focusNode == _fourthDigitFocus) {
              FocusScope.of(context).requestFocus(_thirdDigitFocus);
            }
          }
        },
      ),
    );
  }
}
