import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 1156,
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
                left: 0,
                top: 0,
                child: Container(
                  width: 412,
                  height: 100,
                  decoration: BoxDecoration(
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
              Positioned(
                left: 299,
                top: 41,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCDE6FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFCDE6FE),
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
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 353,
                top: 42,
                child: Container(
                  width: 27,
                  height: 33,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 33,
                top: 35,
                child: Container(
                  width: 36,
                  height: 38,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/36x38"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 138,
                child: Text(
                  'Reports & Analytics',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 205,
                child: Container(
                  width: 351,
                  height: 264,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
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
              Positioned(
                left: 33,
                top: 491,
                child: Container(
                  width: 351,
                  height: 264,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
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
              Positioned(
                left: 47,
                top: 216,
                child: Text(
                  'No of Inspections per Month',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F41BB),
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 49,
                top: 503,
                child: Text(
                  'Shop Grading Distribution',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F41BB),
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 253,
                child: SizedBox(
                  width: 118,
                  height: 16,
                  child: Text(
                    'Month : March',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 313,
                top: 666,
                child: Text(
                  'C Grade',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 313,
                top: 646,
                child: Text(
                  'B Grade',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 313,
                top: 626,
                child: Text(
                  'A Grade',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 313,
                top: 686,
                child: Text(
                  'D Grade',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 789,
                child: Container(
                  width: 351,
                  height: 264,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
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
              Positioned(
                left: 51,
                top: 801,
                child: Text(
                  'Shop Types Distribution',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F41BB),
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 310,
                top: 964,
                child: Text(
                  'Restaurants',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 310,
                top: 944,
                child: Text(
                  'Grocery',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 310,
                top: 924,
                child: Text(
                  'Bakery',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 310,
                top: 984,
                child: Text(
                  'Hotels',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 47,
                top: 824,
                child: Container(
                  width: 318,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: [
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
              Positioned(
                left: 72,
                top: 839,
                child: Container(
                  width: 30,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 305,
                top: 839,
                child: Container(
                  width: 34,
                  height: 34,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
