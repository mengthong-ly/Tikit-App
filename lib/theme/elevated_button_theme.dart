import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  const TElevatedButtonTheme();
  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xff4338CA),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600,),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
    ),
  );
  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xff4338CA),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600,),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
    ),
  );
}
