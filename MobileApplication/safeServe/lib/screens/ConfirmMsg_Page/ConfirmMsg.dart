import 'package:flutter/material.dart';

/// A reusable confirmation dialog component that can be used throughout the app
class ConfirmMsg extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  
  const ConfirmMsg({
    Key? key,
    this.message = 'Are you sure you want to submit this inspection',
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);
  
  // Static method to easily show the dialog from anywhere
  static Future<bool?> show({
    required BuildContext context,
    String message = 'Are you sure you want to submit this inspection',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.white.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: ConfirmMsg(
            message: message,
            onConfirm: () {
              Navigator.of(context).pop(true);
              if (onConfirm != null) onConfirm();
            },
            onCancel: () {
              Navigator.of(context).pop(false);
              if (onCancel != null) onCancel();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 917,
      color: Colors.transparent,
      child: Stack(
        children: [
          // Main dialog box
          Positioned(
            left: 36,
            top: 357,
            child: Container(
              width: 344,
              height: 192,
              decoration: ShapeDecoration(
                color: Colors.white,
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
          // Dialog message
          Positioned(
            left: 45,
            top: 385,
            child: SizedBox(
              width: 319,
              height: 27,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Confirm button
          Positioned(
            left: 223,
            top: 471,
            child: GestureDetector(
              onTap: onConfirm,
              child: Container(
                width: 102,
                height: 38,
                decoration: ShapeDecoration(
                  color: const Color(0xFF3CB851),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Cancel button
          Positioned(
            left: 90,
            top: 471,
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                width: 102,
                height: 38,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFFBB1F21),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFBB1F21),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
