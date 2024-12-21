import 'package:event_with_thong/theme/text_theme.dart';
import 'package:flutter/material.dart';

class TTitleForTextField extends StatelessWidget {
  const TTitleForTextField({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: TTextTheme.lightTextTheme.bodyLarge?.fontSize ?? 14,
        fontWeight: TTextTheme.lightTextTheme.bodyLarge?.fontWeight,
        color: const Color(0xff888888),
      ),
    );
  }
}
