import 'package:event_with_thong/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData theme = TAppTheme.lightTheme;
  bool get isDarkMode => theme == TAppTheme.darkTheme;

  void triggerTheme() {
    theme = theme == TAppTheme.lightTheme
        ? TAppTheme.darkTheme
        : TAppTheme.lightTheme;
    notifyListeners();
  }
}
