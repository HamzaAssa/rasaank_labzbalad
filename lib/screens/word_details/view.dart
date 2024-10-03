import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/favorites/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/word_field/view.dart';
import 'package:rasaank_labzbalad/services/word_service.dart';

class WordDetails extends StatelessWidget {
  final Map<String, dynamic> word;
  const WordDetails({super.key, required this.word});

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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                          print(word["english"]);
                          final balochiMeaning = word["balochi"]["definations"]
                                  .isNotEmpty
                              ? '\nبزانت : ${word["balochi"]["definations"][0]["defination"]}'
                              : "";
                          final urduMeaning = word["urdu"]["definations"]
                                  .isNotEmpty
                              ? '\nمعنی : ${word["urdu"]["definations"][0]["defination"]}'
                              : "";
                          final englishMeaning = word["english"]["definations"]
                                  .isNotEmpty
                              ? '\nMeaning : ${word["english"]["definations"][0]["defination"]}'
                              : "";
                          final romanBalochimeaning = word["romanBalochi"]
                                      ["definations"]
                                  .isNotEmpty
                              ? '\nBezant: ${word["romanBalochi"]["definations"][0]["defination"]}'
                              : "";
                          final finalText =
                              '''(بلوچی)\nلبز : ${word["balochi"]["word"]} $balochiMeaning
                              \n(اردو)\nالفاظ : ${word["urdu"]["word"]} $urduMeaning
                              \n(English)\nWord : ${word["english"]["word"]} $englishMeaning
                              \n(Roman Balochi)\nLabz : ${word["romanBalochi"]["word"]} $romanBalochimeaning''';
                          // print(finalText);
                          WordService.shareWord(finalText);
                        },
                        icon: Icon(
                          Icons.share_rounded,
                          color: primaryColor,
                        ),
                      ),
                      Consumer<FavoriteProvider>(
                          builder: (context, favoriteProvider, child) {
                        return IconButton(
                          color: primaryColor,
                          onPressed: () {
                            favoriteProvider.updateFavorite(word["id"],
                                favoriteProvider.isCurrentWordInFavorite);
                          },
                          isSelected:
                              favoriteProvider.isCurrentWordInFavorite == true,
                          selectedIcon: Icon(
                            Icons.favorite_rounded,
                            color: primaryColor,
                          ),
                          icon: Icon(
                            Icons.favorite_outline,
                            color: primaryColor,
                          ),
                        );
                      }),
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
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 22,
      ),
      // title: Container(
      //   width: 250,
      //   // width: 230,
      //   height: 50,
      //   margin: const EdgeInsets.all(20),
      //   child: CustomPaint(
      //     painter: SShapePainter(primaryColor: primaryColor),
      //     child: const Padding(
      //       padding: EdgeInsets.only(top: 5),
      //       child: Text(
      //         "Word Details",
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //   ),
      // ),
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

class SShapePainter extends CustomPainter {
  final Color primaryColor;
  SShapePainter({required this.primaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = primaryColor;

    // Left side curve
    path.moveTo(0, 0);
    path.quadraticBezierTo(
      size.width * 0.18,
      size.height * 0.1,
      size.width * 0.18,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.18,
      size.height * 0.9,
      size.width * 0.36,
      size.height,
    );

    // Right side curve
    path.lineTo(size.width * 0.7, size.height);
    path.quadraticBezierTo(
      size.width * 0.82,
      size.height * 0.9,
      size.width * 0.82,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.82,
      size.height * 0.1,
      size.width,
      0,
    );

    path.lineTo(size.width, 0);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
