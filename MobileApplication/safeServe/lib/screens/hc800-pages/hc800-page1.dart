import 'package:flutter/material.dart';

class Hc800Page1 extends StatelessWidget {
  const Hc800Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Hc800(),
        ],
      ),
    );
  }
}

class Hc800 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 1703,
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
              // ...existing code...
            ],
          ),
        ),
      ],
    );
  }
}
