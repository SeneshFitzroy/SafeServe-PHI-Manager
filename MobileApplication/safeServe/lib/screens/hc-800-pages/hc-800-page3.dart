import 'package:flutter/material.dart';

class Hc800Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFE6F5FE), const Color(0xFFF5ECF9)],
          ),
        ),
        child: ListView(
          children: [
            _buildHeader(),
            _buildTitle('HC 800 Form'),
            _buildProgressBar(),
            _buildSectionTitle(
                'Part 10 - Display of Health Instructions, Record Keeping & Certification'),
            _buildQuestion(
                '10.1 Display of instruction and health messages for the consumers/employees'),
            _buildYesNoOptions(),
            _buildQuestion(
                '10.2 Entertains consumer/employee complaints and suggestions'),
            _buildYesNoOptions(),
            _buildQuestion(
                '10.3 Steps taken to prevent smoking within the premises'),
            _buildYesNoOptions(),
            _buildQuestion(
                '10.4 Issuing of bills and record keeping when selling/purchasing food'),
            _buildYesNoOptions(),
            _buildQuestion(
                '10.5 Availability of accredited certification on food safety'),
            _buildYesNoOptions(),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
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
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 33, top: 20),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 33, top: 20),
      child: Stack(
        children: [
          Container(
            width: 351,
            height: 15,
            decoration: ShapeDecoration(
              color: const Color(0xFFCDE6FE),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: const Color(0xFF4189FC),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            width: 308,
            height: 15,
            decoration: ShapeDecoration(
              color: const Color(0xFF4189FC),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFF4189FC),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 33, top: 20),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF1F41BB),
          fontSize: 22,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.only(left: 33, top: 20),
      child: Text(
        question,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildYesNoOptions() {
    return Padding(
      padding: const EdgeInsets.only(left: 33, top: 10),
      child: Row(
        children: [
          _buildOptionCircle(const Color(0xFF3CB851)),
          const SizedBox(width: 10),
          Text(
            'Yes',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 30),
          _buildOptionCircle(const Color(0xFFBB1F21)),
          const SizedBox(width: 10),
          Text(
            'No',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCircle(Color borderColor) {
    return Container(
      width: 30,
      height: 30,
      decoration: ShapeDecoration(
        shape: OvalBorder(
          side: BorderSide(
            width: 2,
            color: borderColor,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 33, top: 20, right: 33, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton('Previous', const Color(0xFF1F41BB), Colors.white),
          _buildButton('Next', Colors.white, const Color(0xFF1F41BB)),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color textColor, Color backgroundColor) {
    return Container(
      width: 102,
      height: 38,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: const Color(0xFF1F41BB),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
