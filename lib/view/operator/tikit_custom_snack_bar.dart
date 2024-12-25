import 'package:flutter/material.dart';

class TikitCustomSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        closeIconColor: Colors.white,
        elevation: 10,
        showCloseIcon: true,
        backgroundColor: Colors.black, // Customize background color
        behavior: SnackBarBehavior.floating, // Optional customization
        duration:
            const Duration(seconds: 3), // Duration the SnackBar is visible
      ),
    );
  }
}
