import 'package:flutter/material.dart';

class TTextTheme {
  const TTextTheme();

  static TextTheme lightTextTheme = TextTheme(

    headlineLarge: const TextStyle().copyWith(fontSize: 32,fontWeight: FontWeight.w600,color: const Color(0xff202020)),
    headlineMedium: const TextStyle().copyWith(fontSize: 24,fontWeight: FontWeight.w600,color: const Color(0xff202020)),
    headlineSmall: const TextStyle().copyWith(fontSize: 18,fontWeight: FontWeight.w600,color: const Color(0xff202020)),

    titleLarge: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600,color: const Color(0xff202020)),
    titleMedium: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600,color: const Color(0xff202020)),
    titleSmall: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: const Color(0xff202020)),

    bodyLarge: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0xff202020)),
    bodyMedium: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0xff202020)),
    bodySmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0xff202020).withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: const Color(0xff202020)),
    labelMedium: const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: const Color(0xff202020).withOpacity(0.5)),
       
    );

  static TextTheme darkTextTheme =  TextTheme(

    headlineLarge: const TextStyle().copyWith(fontSize: 32,fontWeight: FontWeight.bold,color: const Color(0xfff2f2f2)),
    headlineMedium: const TextStyle().copyWith(fontSize: 24,fontWeight: FontWeight.w600,color: const Color(0xfff2f2f2)),
    headlineSmall: const TextStyle().copyWith(fontSize: 18,fontWeight: FontWeight.w600,color: const Color(0xfff2f2f2)),

    titleLarge: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600,color: const Color(0xfff2f2f2)),
    titleMedium: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: const Color(0xfff2f2f2)),
    titleSmall: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: const Color(0xfff2f2f2)),

    bodyLarge: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0xfff2f2f2)),
    bodyMedium: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0xfff2f2f2)),
    bodySmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0xfff2f2f2).withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: const Color(0xfff2f2f2)),
    labelMedium: const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: const Color(0xfff2f2f2).withOpacity(0.5)),
       
    
  );
}
