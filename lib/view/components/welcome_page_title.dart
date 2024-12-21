import 'package:event_with_thong/theme/text_theme.dart';
import 'package:flutter/material.dart';

class WelcomePageTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const WelcomePageTitle({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          // 'Let\'s start the Event! ',
          title,
          style: TTextTheme.lightTextTheme.headlineMedium,
        ),
        Text(
          // 'Every Event is now your with\njust a single click',
          subTitle,
          textAlign: TextAlign.center,
          style: TTextTheme.lightTextTheme.bodySmall,
        ),
      ],
    );
  }
}
