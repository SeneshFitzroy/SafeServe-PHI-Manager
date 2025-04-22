import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../../widgets/custom_nav_bar_icon.dart';
import 'notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Using a list that can be modified
  late List<NotificationItem> notifications;
  
  @override
  void initState() {
    super.initState();
    // Initialize notifications data
    notifications = [
      NotificationItem(
        id: '1',
        title: 'Inspection Reminder',
        message: 'You have an upcoming inspection at Food Corner on 02/05/2023',
        time: '2 hours ago',
        isNew: true,
        icon: Icons.assignment_outlined,
        iconColor: Colors.blue,
      ),
      NotificationItem(
        id: '2',
        title: 'Food Safety Alert',
        message: 'New food safety guidelines have been published. Check them now!',
        time: 'Yesterday',
        isNew: true,
        icon: Icons.warning_amber_outlined,
        iconColor: Colors.orange,
      ),
      NotificationItem(
        id: '3',
        title: 'Form Submission',
        message: 'H800 form for Tasty Bites was submitted successfully',
        time: '2 days ago',
        isNew: false,
        icon: Icons.check_circle_outline,
        iconColor: Colors.green,
      ),
      NotificationItem(
        id: '4',
        title: 'Report Generated',
        message: 'Monthly safety report is ready for review',
        time: '1 week ago',
        isNew: false,
        icon: Icons.description_outlined,
        iconColor: Colors.purple,
      ),
      NotificationItem(
        id: '5',
        title: 'System Update',
        message: 'SafeServe has been updated to version 2.0',
        time: '2 weeks ago',
        isNew: false,
        icon: Icons.system_update_outlined,
        iconColor: Colors.teal,
      ),
    ];
  }

  // Method to clear all notifications
  void clearAllNotifications() {
    setState(() {
      notifications = []; // Clear the list by assigning an empty list
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All notifications cleared'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  // Method to remove individual notification
  void removeNotification(String id) {
    setState(() {
      notifications.removeWhere((notification) => notification.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 100,
        onMenuPressed: () {
          Navigator.pushNamed(context, '/menu');
        },
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications header with clear all button
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (notifications.isNotEmpty) // Only show button if there are notifications
                    TextButton.icon(
                      onPressed: clearAllNotifications, // Connect to the clearAllNotifications method
                      icon: Icon(Icons.delete_outline, color: Color(0xFF1F41BB)),
                      label: Text(
                        'Clear All',
                        style: TextStyle(
                          color: Color(0xFF1F41BB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Notifications list
            Expanded(
              child: notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No notifications yet',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Dismissible(
                          key: Key(notification.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            removeNotification(notification.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Notification removed'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: NotificationCard(
                              notification: notification,
                              onRead: () {
                                // Mark as read functionality (optional)
                                if (notification.isNew) {
                                  setState(() {
                                    // Create a new list with updated notification
                                    notifications = notifications.map((item) {
                                      if (item.id == notification.id) {
                                        return NotificationItem(
                                          id: item.id,
                                          title: item.title,
                                          message: item.message,
                                          time: item.time,
                                          isNew: false,
                                          icon: item.icon,
                                          iconColor: item.iconColor,
                                        );
                                      }
                                      return item;
                                    }).toList();
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 38),
        child: Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomNavBarIcon(
                icon: Icons.home_outlined,
                label: 'Home',
                route: '/',
                selected: false,
              ),
              CustomNavBarIcon(
                icon: Icons.calendar_today_outlined,
                label: 'Calendar',
                route: '/calendar',
                selected: false,
              ),
              CustomNavBarIcon(
                icon: Icons.notifications,
                label: 'Notifications',
                route: '/notifications',
                selected: true,
              ),
              CustomNavBarIcon(
                icon: Icons.person_outline,
                label: 'Profile',
                route: '/profile',
                selected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback? onRead;

  const NotificationCard({
    Key? key,
    required this.notification,
    this.onRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: notification.isNew ? Colors.white : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        boxShadow: notification.isNew
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                )
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Handle notification tap - mark as read
              if (onRead != null) {
                onRead!();
              }
              
              // Show notification details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Viewing: ${notification.title}'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon with colored background
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: notification.iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      notification.icon,
                      color: notification.iconColor,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 15),
                  // Notification content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Title with new indicator if needed
                            Row(
                              children: [
                                Text(
                                  notification.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                if (notification.isNew) ...[
                                  SizedBox(width: 8),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1F41BB),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            // Time
                            Text(
                              notification.time,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        // Message
                        Text(
                          notification.message,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
