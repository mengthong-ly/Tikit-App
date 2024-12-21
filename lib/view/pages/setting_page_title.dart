import 'package:flutter/material.dart';

class SettingPageTitle extends StatelessWidget {
  final String title;
  const SettingPageTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
            color: Color(0xffFD2942),
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.start,
      ),
    );
  }
}
