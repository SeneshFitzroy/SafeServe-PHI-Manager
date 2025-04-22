import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final bool isNew;
  final IconData icon;
  final Color iconColor;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isNew,
    required this.icon,
    required this.iconColor,
  });
}
