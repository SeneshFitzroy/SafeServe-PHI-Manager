import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 1559,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.00),
              colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
            ),
          ),
          child: Stack(
            children: [
              // App Bar
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 412,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 412,
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
                        ),
                      ),
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
                        left: 299,
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
                        ),
                      ),
                      Positioned(
                        left: 349,
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
                        ),
                      ),
                      Positioned(
                        left: 304,
                        top: 46,
                        child: Container(
                          width: 25,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Stack(),
                        ),
                      ),
                      Positioned(
                        left: 353,
                        top: 42,
                        child: Container(
                          width: 27,
                          height: 33,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Stack(),
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
                    ],
                  ),
                ),
              ),
              
              // Profile Title and Back Button
              const Positioned(
                left: 159,
                top: 137,
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 135,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCDE6FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 137,
                child: Container(
                  width: 35,
                  height: 32,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: const Stack(),
                ),
              ),
              
              // Profile Picture
              Positioned(
                left: 131,
                top: 199,
                child: Container(
                  width: 150,
                  height: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: const Stack(),
                ),
              ),
              
              // Profile Information Fields
              // PHI ID Field
              _buildInfoField(left: 33, top: 393, label: 'PHI ID', value: '73929302', fieldTop: 427),
              
              // Full Name Field
              _buildInfoField(left: 33, top: 500, label: 'Full Name', value: 'Leo Perera', fieldTop: 538),
              
              // NIC Field
              _buildInfoField(left: 33, top: 610, label: 'NIC', value: '7192819020v', fieldTop: 644),
              
              // Phone Number Field
              _buildInfoField(left: 33, top: 721, label: 'Phone Number', value: '0715645349', fieldTop: 758),
              
              // Email Field
              _buildInfoField(left: 33, top: 833, label: 'Email', value: 'Leoperera@gmail.com', fieldTop: 871),
              
              // Personal Address Field
              _buildInfoField(left: 33, top: 948, label: 'Personal Address', value: '648 Colombo North Colombo', fieldTop: 988),
              
              // District Field
              _buildInfoField(left: 33, top: 1064, label: 'District', value: 'Colombo', fieldTop: 1102),
              
              // GN Divisions Fields
              const Positioned(
                left: 33,
                top: 1179,
                child: SizedBox(
                  width: 160,
                  height: 40,
                  child: Text(
                    'GN Divisions',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              // GN Division Fields - First Row
              _buildSmallField(left: 33, top: 1219, width: 105, value: 'Kottawa'),
              _buildSmallField(left: 151, top: 1219, width: 129, value: 'Homagama'),
              _buildSmallField(left: 293, top: 1222, width: 89, value: 'Pitipana'),
              
              // GN Division Fields - Second Row
              _buildSmallField(left: 33, top: 1274, width: 78, value: 'Kotte'),
              _buildSmallField(left: 151, top: 1274, width: 115, value: 'Biyagama'),
              
              // Buttons
              // Change Password Button
              Positioned(
                left: 33,
                top: 1379,
                child: Container(
                  width: 349,
                  height: 55,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2,
                        color: Color(0xFF1F41BB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 96.73,
                top: 1392,
                child: SizedBox(
                  width: 222.55,
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: Color(0xFF1F41BB),
                      fontSize: 25,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              
              // Log Out Button
              Positioned(
                left: 33,
                top: 1455,
                child: Container(
                  width: 349,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1F41BB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 180.69,
                top: 1468,
                child: SizedBox(
                  width: 98.12,
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 140,
                top: 1471,
                child: Container(
                  width: 25,
                  height: 24,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: const Stack(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Helper method to build an information field with label and value
  Widget _buildInfoField({required double left, required double top, required String label, required String value, required double fieldTop}) {
    return Stack(
      children: [
        // Label
        Positioned(
          left: left,
          top: top,
          child: SizedBox(
            width: 160,
            height: 40,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        // Field Container
        Positioned(
          left: left,
          top: fieldTop,
          child: Container(
            width: 349,
            height: 40,
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
          ),
        ),
        // Value
        Positioned(
          left: left + 15,
          top: fieldTop + 8,
          child: SizedBox(
            width: 330,
            height: 40,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // Helper method to build small fields for GN Divisions
  Widget _buildSmallField({required double left, required double top, required double width, required String value}) {
    return Stack(
      children: [
        Positioned(
          left: left,
          top: top,
          child: Container(
            width: width,
            height: 40,
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
          ),
        ),
        Positioned(
          left: left + 15,
          top: top + 10,
          child: SizedBox(
            width: width - 15,
            height: 40,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
