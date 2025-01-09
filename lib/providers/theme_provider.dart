import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData;
  Brightness _brightness;
  final Color _seedColor = Colors.pink;
  String themeMode = "light";

  static const themeKey = "THEME_BRIGHTNESS";

  ThemeProvider() : _brightness = Brightness.light {
    // Initialize default theme
    _themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: _brightness,
      ),
      useMaterial3: true,
      fontFamily: 'Staatliches',
    );
  }
  ThemeData get themeData => _themeData;

  Future<void> loadThemeSynchronously() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(themeKey) ?? "light";

    // Update brightness and themeMode based on saved preference
    themeMode = savedTheme;
    _brightness = savedTheme == "dark" ? Brightness.dark : Brightness.light;

    // Apply the theme
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

  void _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(themeKey, themeMode);
  }

  void toggleTheme() {
    // Toggle brightness and update theme mode
    if (_brightness == Brightness.light) {
      _brightness = Brightness.dark;
      themeMode = "dark";
    } else {
      _brightness = Brightness.light;
      themeMode = "light";
    }

    // Update the theme
    _themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: _brightness,
      ),
      useMaterial3: true,
      fontFamily: 'Staatliches',
    );

    _saveTheme();
    notifyListeners();
  }
}
