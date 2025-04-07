import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 412,
        height: 917,
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
            // Title
            const Positioned(
              left: 41,
              top: 145,
              child: Text(
                'Notifications',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // Bottom Navigation
            Positioned(
              left: 35,
              top: 819,
              child: Container(
                width: 318,
                height: 60,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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
            Positioned(
              left: 283,
              top: 822,
              child: Container(
                width: 53,
                height: 54,
                decoration: const ShapeDecoration(
                  color: Color(0xFFCDE6FE),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 60,
              top: 834,
              child: Container(
                width: 30,
                height: 30,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: const Stack(),
              ),
            ),
            Positioned(
              left: 293,
              top: 834,
              child: Container(
                width: 34,
                height: 34,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: const Stack(),
              ),
            ),
            
            // Here you would add notification items
            // Example placeholder for notification list
            Positioned(
              left: 25,
              top: 190,
              child: Container(
                width: 360,
                height: 600,
                child: ListView.builder(
                  itemCount: 5, // Replace with actual notification count
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.notifications, color: Color(0xFF1F41BB)),
                        title: Text('Notification Title ${index + 1}'),
                        subtitle: const Text('Notification details here'),
                        trailing: const Text('2h ago'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
