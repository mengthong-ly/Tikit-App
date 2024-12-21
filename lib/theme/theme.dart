//  this is like create a enum
import 'package:event_with_thong/theme/elevated_button_theme.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  const TAppTheme();

  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xfff4f4f4),
      fontFamily: 'Poppins',
      primaryColor: const Color(0xffFD2942),
      brightness: Brightness.light,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme);

  static ThemeData darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xff303030),
      fontFamily: 'Poppins',
      primaryColor: const Color(0xffFD2942),
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme);
}
