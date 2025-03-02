import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/favorites/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/word_field/view.dart';
import 'package:rasaank_labzbalad/services/word_service.dart';

class WordDetails extends StatelessWidget {
  final Map<String, dynamic> word;
  final bool fromUnverified;
  const WordDetails({
    super.key,
    required this.word,
    this.fromUnverified = false,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);
    TextDirection textDirection = _getTextDirectionn();

    return Theme(
      data: _themeData(context, primaryColor),
      child: Scaffold(
        appBar: _appBar(context, primaryColor),
        body: _body(primaryColor, textDirection, context),
      ),
    );
  }

  TextDirection _getTextDirectionn() {
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
    return textDirection;
  }

  SingleChildScrollView _body(
      Color primaryColor, TextDirection textDirection, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        color: primaryColor,
                        onPressed: () {
                          final word = Provider.of<WordDetailsProvider>(context,
                                  listen: false)
                              .word;
                          final balochiMeaning = word["balochi"]["definitions"]
                                  .isNotEmpty
                              ? '${word["balochi"]["definitions"][0]["definition"]}'
                              : "";
                          final urduMeaning = word["urdu"]["definitions"]
                                  .isNotEmpty
                              ? '${word["urdu"]["definitions"][0]["definition"]}'
                              : "";
                          final englishMeaning = word["english"]["definitions"]
                                  .isNotEmpty
                              ? '${word["english"]["definitions"][0]["definition"]}'
                              : "";
                          final romanBalochimeaning = word["romanBalochi"]
                                      ["definitions"]
                                  .isNotEmpty
                              ? '${word["romanBalochi"]["definitions"][0]["definition"]}'
                              : "";
                          final balochiWord = word["balochi"]["word"].isNotEmpty
                              ? '${word["balochi"]["word"]}'
                              : "";
                          final urduWord = word["urdu"]["word"].isNotEmpty
                              ? '${word["urdu"]["word"]}'
                              : "";
                          final englishWord = word["english"]["word"].isNotEmpty
                              ? '${word["english"]["word"]}'
                              : "";
                          final romanBalochiWord =
                              word["romanBalochi"]["word"].isNotEmpty
                                  ? '${word["romanBalochi"]["word"]}'
                                  : "";
                          final finalText =
                              '''(بلوچی)\nلبز : $balochiWord \nبزانت : $balochiMeaning
                              \n(اردو)\nالفاظ : $urduWord \nمعنی : $urduMeaning
                              \n(English)\nWord : $englishWord \nMeaning : $englishMeaning
                              \n(Roman Balochi)\nLabz : $romanBalochiWord \nBezant: $romanBalochimeaning''';
                          // print(finalText);
                          WordService.shareWord(finalText);
                        },
                        icon: Icon(
                          Icons.share_rounded,
                          color: primaryColor,
                        ),
                      ),
                      !fromUnverified
                          ? Consumer<FavoriteProvider>(
                              builder: (context, favoriteProvider, child) {
                              return IconButton(
                                color: primaryColor,
                                onPressed: () {
                                  favoriteProvider.updateFavorite(word["id"],
                                      favoriteProvider.isCurrentWordInFavorite);
                                },
                                isSelected:
                                    favoriteProvider.isCurrentWordInFavorite ==
                                        true,
                                selectedIcon: Icon(
                                  Icons.favorite_rounded,
                                  color: primaryColor,
                                ),
                                icon: Icon(
                                  Icons.favorite_outline,
                                  color: primaryColor,
                                ),
                              );
                            })
                          : const SizedBox(
                              width: 40,
                            ),
                    ],
                  ),
                ),
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
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 7, right: 7, bottom: 10, top: 20),
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
                    WordField(
                      word: wordDetailsProvider.word["balochi"],
                      language: "Balochi",
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 10),
                    WordField(
                      word: wordDetailsProvider.word["urdu"],
                      language: "Urdu",
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 10),
                    WordField(
                      word: wordDetailsProvider.word["english"],
                      language: "English",
                      textDirection: TextDirection.ltr,
                    ),
                    const SizedBox(height: 10),
                    WordField(
                      word: wordDetailsProvider.word["romanBalochi"],
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
      title: SizedBox(
        height: 35,
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
                  bottom: Radius.circular(25),
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
