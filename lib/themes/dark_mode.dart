import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 18, 18, 18), // Dark surface
    primary: Color.fromARGB(255, 26, 148, 134), // Same primary for consistency
    secondary: Color.fromARGB(255, 40, 40, 40), // A dark muted secondary
    tertiary: Color.fromARGB(255, 50, 50, 50), // Slightly lighter for depth
    inversePrimary:
        Color.fromARGB(255, 255, 255, 255), // White for inverse elements
    onSurface: Color.fromARGB(255, 255, 255, 255), // White text on surface
    onPrimary: Color.fromARGB(255, 0, 0, 0), // Black text on primary
    onSecondary: Color.fromARGB(255, 255, 255, 255), // White text on secondary
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 18, 18, 18),
      statusBarIconBrightness: Brightness.light,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Color.fromARGB(255, 18, 18, 18),
    ),
  ),
);
