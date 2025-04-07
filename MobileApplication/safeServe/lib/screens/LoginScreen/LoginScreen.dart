import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 917,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.00),
              colors: [const Color(0xFFE6F5FE), const Color(0xFFF5ECF9)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 34,
                top: 201,
                child: Container(
                  width: 343,
                  height: 489,
                  padding: const EdgeInsets.all(24),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 85,
                        height: 86,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://placehold.co/85x86"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                color: const Color(0xFF111827),
                                fontSize: 32,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 1.30,
                                letterSpacing: -0.64,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Enter your username and password to log in ',
                              style: TextStyle(
                                color: const Color(0xFF6C7278),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: -0.12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 21,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Username',
                                          style: TextStyle(
                                            color: const Color(0xFF6C7278),
                                            fontSize: 12,
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontWeight: FontWeight.w500,
                                            height: 1.60,
                                            letterSpacing: -0.24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Container(
                                    width: double.infinity,
                                    height: 46,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 27),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0x54CDE6FE),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: const Color(0xFFCDE6FE),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x3DE4E5E7),
                                          blurRadius: 2,
                                          offset: Offset(0, 1),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 10),
                                              SizedBox(
                                                width: 207,
                                                height: 21,
                                                child: Text(
                                                  'leoperera',
                                                  style: TextStyle(
                                                    color: const Color(0xFF1A1C1E),
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.40,
                                                    letterSpacing: -0.14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 21,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Password',
                                          style: TextStyle(
                                            color: const Color(0xFF6C7278),
                                            fontSize: 12,
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontWeight: FontWeight.w500,
                                            height: 1.60,
                                            letterSpacing: -0.24,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Container(
                                    width: double.infinity,
                                    height: 46,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 27),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0x54CDE6FE),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: const Color(0xFFCDE6FE),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x3DE4E5E7),
                                          blurRadius: 2,
                                          offset: Offset(0, 1),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 12),
                                              SizedBox(
                                                width: 207,
                                                height: 21,
                                                child: Text(
                                                  '*******',
                                                  style: TextStyle(
                                                    color: const Color(0xFF1A1C1E),
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.40,
                                                    letterSpacing: -0.14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 16,
                                          height: 16,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(),
                                          child: Stack(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.50, -0.00),
                                  end: Alignment(0.50, 1.00),
                                  colors: [Colors.white, Colors.white.withOpacity(0)],
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.white.withOpacity(0.12),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0xFF375DFB),
                                    blurRadius: 0,
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Color(0x7A253EA7),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 1.40,
                                      letterSpacing: -0.22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
