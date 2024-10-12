import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
const Color onWhiteSurfaceColor = Color.fromARGB(255, 60, 60, 60);
const Color primaryColor = Color.fromARGB(255, 26, 100, 100);
const Color secondaryColor = Color.fromARGB(255, 26, 148, 134);
ThemeData lightMode = ThemeData(
    colorScheme: const ColorScheme.light(
      surface: whiteColor,
      primary: Color.fromARGB(255, 26, 148, 134),
      secondary:
          Color.fromARGB(255, 220, 240, 230), // A soft complementary color
      tertiary: Color.fromARGB(
          255, 200, 225, 215), // A light shade for additional accents
      inversePrimary: whiteColor, // White for inverse elements
      onSurface: onWhiteSurfaceColor, // Dark text on surface
      onPrimary: whiteColor, // White text on primary
      onSecondary: Color.fromARGB(255, 0, 0, 0), // Black text on secondary
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: whiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: whiteColor,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: primaryColor,
    ));
