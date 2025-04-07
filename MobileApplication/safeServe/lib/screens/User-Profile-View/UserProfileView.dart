import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              
              // Back Button and Profile Title
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    const SizedBox(width: 33),
                    Container(
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
                    const Expanded(
                      child: Center(
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
                    ),
                    const SizedBox(width: 68),
                  ],
                ),
              ),
              
              // Profile Picture
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage("https://placehold.co/150x150"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Profile Information Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoFieldResponsive(label: 'PHI ID', value: '73929302'),
                    const SizedBox(height: 30),
                    
                    _buildInfoFieldResponsive(label: 'Full Name', value: 'Leo Perera'),
                    const SizedBox(height: 30),
                    
                    _buildInfoFieldResponsive(label: 'NIC', value: '7192819020v'),
                    const SizedBox(height: 30),
                    
                    _buildInfoFieldResponsive(label: 'Phone Number', value: '0715645349'),
                    const SizedBox(height: 30),
                    
                    _buildInfoFieldResponsive(label: 'Email', value: 'Leoperera@gmail.com'),
                    const SizedBox(height: 30),
                    
                    _buildInfoFieldResponsive(label: 'Personal Address', value: '648 Colombo North Colombo'),
                    const SizedBox(height: 30),
                    
                    _buildInfoFieldResponsive(label: 'District', value: 'Colombo'),
                    const SizedBox(height: 30),
                    
                    // GN Divisions Section
                    const Text(
                      'GN Divisions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // First Row of GN Divisions
                    Row(
                      children: [
                        _buildSmallFieldResponsive(value: 'Kottawa', width: 105),
                        const SizedBox(width: 13),
                        _buildSmallFieldResponsive(value: 'Homagama', width: 129),
                        const SizedBox(width: 13),
                        _buildSmallFieldResponsive(value: 'Pitipana', width: 89),
                      ],
                    ),
                    const SizedBox(height: 15),
                    
                    // Second Row of GN Divisions
                    Row(
                      children: [
                        _buildSmallFieldResponsive(value: 'Kotte', width: 78),
                        const SizedBox(width: 13),
                        _buildSmallFieldResponsive(value: 'Biyagama', width: 115),
                      ],
                    ),
                    
                    // Action Buttons
                    const SizedBox(height: 40),
                    _buildActionButton(
                      text: 'Change Password',
                      isOutlined: true,
                      onPressed: () {
                        // Handle change password
                      }
                    ),
                    const SizedBox(height: 20),
                    _buildActionButton(
                      text: 'Log Out',
                      isOutlined: false,
                      onPressed: () {
                        // Handle log out
                      }
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
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
  
  Widget _buildInfoFieldResponsive({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
          alignment: Alignment.centerLeft,
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
      ],
    );
  }
  
  Widget _buildSmallFieldResponsive({required String value, required double width}) {
    return Container(
      width: width,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
      alignment: Alignment.centerLeft,
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
  
  Widget _buildActionButton({
    required String text,
    required bool isOutlined,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : const Color(0xFF1F41BB),
          side: isOutlined ? const BorderSide(color: Color(0xFF1F41BB), width: 2) : null,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isOutlined ? const Color(0xFF1F41BB) : Colors.white,
            fontSize: 25,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
