import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/word_title/view.dart';

class WordDetails extends StatelessWidget {
  final Map<String, dynamic> word;
  const WordDetails({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);
    TextDirection textDirection = TextDirection.ltr;
    if (word["language"] == "BL") {
      textDirection = TextDirection.rtl;
    } else if (word["language"] == "UR") {
      textDirection = TextDirection.rtl;
    } else if (word["language"] == "EN") {
      textDirection = TextDirection.ltr;
    } else if (word["language"] == "RB") {
      textDirection = TextDirection.ltr;
    }

    return Theme(
      data: _themeData(context, primaryColor),
      child: Scaffold(
        appBar: _appBar(context, primaryColor),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Text(
                    word["word"],
                    textDirection: textDirection,
                    style: TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 10, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Consumer<WordDetailsProvider>(
                      builder: (context, wordDetailsProvider, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WordTitle(
                          title: wordDetailsProvider.word["balochiWord"],
                          language: "Balochi",
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 10),
                        WordTitle(
                          title: wordDetailsProvider.word["urduWord"],
                          language: "Urdu",
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 10),
                        WordTitle(
                          title: wordDetailsProvider.word["englishWord"],
                          language: "English",
                          textDirection: TextDirection.ltr,
                        ),
                        const SizedBox(height: 10),
                        WordTitle(
                          title: wordDetailsProvider.word["romanBalochiWord"],
                          language: "Roman Balochi",
                          textDirection: TextDirection.ltr,
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
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
        color: Theme.of(context).colorScheme.surface,
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
              child: const Text('Word Details'),
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
