import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/screens/about_us/view.dart';
import 'package:rasaank_labzbalad/screens/unverified_words/add_word/view.dart';
import 'package:rasaank_labzbalad/screens/favorites/view.dart';
import 'package:rasaank_labzbalad/screens/word_list/view.dart';

class BottomNavbar extends StatelessWidget {
  final int selected;
  final double _iconSize = 26;
  const BottomNavbar({super.key, required this.selected});

  Widget _createButton(
    int index,
    String text,
    IconData icon,
    IconData selectedIcon,
    Color primaryColor,
    Color grayColor,
    Color surfaceColor,
    Function onSelectScreen,
  ) {
    return index == selected
        ? TextButton(
            style: ButtonStyle(
              overlayColor:
                  WidgetStateColor.resolveWith((states) => surfaceColor),
            ),
            onPressed: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selectedIcon,
                  size: _iconSize,
                ),
                Text(text)
              ],
            ),
          )
        : IconButton(
            onPressed: () => onSelectScreen(),
            isSelected: selected == index,
            selectedIcon: Icon(
              size: _iconSize,
              selectedIcon,
              color: primaryColor,
            ),
            icon: Icon(
              size: _iconSize,
              icon,
              color: grayColor,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color grayColor = const Color.fromARGB(255, 100, 100, 100);
    Color surfaceColor = Theme.of(context).colorScheme.surface;
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _createButton(
            4,
            "About",
            Icons.info_outlined,
            Icons.info_rounded,
            primaryColor,
            grayColor,
            surfaceColor,
            () => {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const AboutPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // return FadeTransition(opacity: animation, child: child);
                    return child;
                  },
                ),
              ),
            },
          ),
          // _createButton(
          //     3,
          //     "Settings",
          //     Icons.settings_outlined,
          //     Icons.settings_rounded,
          //     primaryColor,
          //     grayColor,
          //     surfaceColor,
          //     () => Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AddUnverifiedWord(),),),),
          _createButton(
            2,
            "Add Word",
            Icons.add_box_outlined,
            Icons.add_box_rounded,
            primaryColor,
            grayColor,
            surfaceColor,
            () => {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      AddUnverifiedWord(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // return FadeTransition(opacity: animation, child: child);
                    return child;
                  },
                ),
              ),
            },
          ),

          _createButton(
            1,
            "Favorites",
            Icons.favorite_outline,
            Icons.favorite_rounded,
            primaryColor,
            grayColor,
            surfaceColor,
            () => {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const FavoriteList(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // return FadeTransition(opacity: animation, child: child);
                    return child;
                  },
                ),
              ),
            },
          ),
          _createButton(
            0,
            "Words",
            Icons.library_books_outlined,
            Icons.library_books_rounded,
            primaryColor,
            grayColor,
            surfaceColor,
            () => {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const WordList(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // return FadeTransition(opacity: animation, child: child);
                    return child;
                  },
                ),
              ),
            },
          ),
        ],
      ),
    );
  }
}
