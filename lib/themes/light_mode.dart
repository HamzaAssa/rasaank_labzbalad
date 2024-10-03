import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 255, 255, 255),
    primary: Color.fromARGB(255, 26, 148, 134),
    secondary: Color.fromARGB(255, 220, 240, 230), // A soft complementary color
    tertiary: Color.fromARGB(
        255, 200, 225, 215), // A light shade for additional accents
    inversePrimary:
        Color.fromARGB(255, 255, 255, 255), // White for inverse elements
    onSurface: Color.fromARGB(255, 60, 60, 60), // Dark text on surface
    onPrimary: Color.fromARGB(255, 255, 255, 255), // White text on primary
    onSecondary: Color.fromARGB(255, 0, 0, 0), // Black text on secondary
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 255, 255, 255),
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Color.fromARGB(255, 255, 255, 255),
    ),
  ),
  // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
  //   elevation: 0,
  //   enableFeedback: false,
  //   selectedIconTheme: IconThemeData(
  //     color: Color.fromARGB(255, 26, 148, 134),
  //   ),
  //   unselectedIconTheme: IconThemeData(
  //     color: Color.fromARGB(255, 80, 80, 80),
  //   ),
  // ),
);
