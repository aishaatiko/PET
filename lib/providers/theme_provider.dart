import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  Brightness _brightness = Brightness.light;
  final Color _seedColor = Colors.pink;

  ThemeProvider()
      : _themeData = ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
          fontFamily: 'Staatliches',
        );

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _brightness =
        _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    _themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: _brightness,
      ),
      useMaterial3: true,
      fontFamily: 'Staatliches',
    );
    notifyListeners();
  }
}
