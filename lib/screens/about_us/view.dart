import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rasaank_labzbalad/screens/components/bottom_navbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);

    return Theme(
      data: _themeData(context, primaryColor),
      child: Scaffold(
        appBar: _appBar(context, primaryColor),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: const Center(
              child: Text("About page"),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(
          selected: 4,
        ),
      ),
    );
  }

  ThemeData _themeData(context, primaryColor) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }

  AppBar _appBar(context, primaryColor) {
    return AppBar(
      toolbarHeight: 35,
      scrolledUnderElevation: 0.0,
      leading: const SizedBox(),
      leadingWidth: 0,
      titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 22,
      ),
      title: Container(
        height: 35,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
            )),
            Container(
              height: 35,
              padding: const EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(130),
                ),
              ),
              child: const Text('About US'),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
