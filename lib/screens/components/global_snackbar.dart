import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showGlobalSnackbar(Map<String, dynamic> data, Color primaryColor) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: data["statusCode"] == 500 ? Colors.red : primaryColor,
      content: Text(data["body"]),
      duration: const Duration(seconds: 3),
    ),
  );
}
