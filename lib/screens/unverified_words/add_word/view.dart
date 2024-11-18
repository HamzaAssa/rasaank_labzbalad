import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/components/bottom_navbar.dart';
import 'package:rasaank_labzbalad/screens/components/global_snackbar.dart';
import 'package:rasaank_labzbalad/screens/unverified_words/add_word/component/word_field.dart';
import 'package:rasaank_labzbalad/screens/unverified_words/word_list/provider.dart';
import 'package:rasaank_labzbalad/screens/unverified_words/word_list/view.dart';
import 'package:rasaank_labzbalad/themes/light_mode.dart';

class AddUnverifiedWord extends StatelessWidget {
  final TextEditingController balochiTextController = TextEditingController();
  final TextEditingController urduTextController = TextEditingController();
  final TextEditingController englishTextController = TextEditingController();
  final TextEditingController romanBalochiTextController =
      TextEditingController();
  AddUnverifiedWord({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);

    return Theme(
      data: _themeData(context, primaryColor),
      child: Scaffold(
        appBar: _appBar(context, primaryColor),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const UnverifiedWordsList(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                // return FadeTransition(opacity: animation, child: child);
                                return child;
                              },
                            ),
                            // MaterialPageRoute(
                            //   builder: (context) => const UnverifiedWordsList(),
                            // ),
                          );
                        },
                        child: const Text("Unverified Words"),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          _showDownloadDialog(context);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.download),
                            SizedBox(width: 5),
                            Text("Download Words"),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WordField(
                            title: "Balochi",
                            textDirection: TextDirection.rtl,
                            textEditingController: balochiTextController),
                        const SizedBox(height: 10),
                        WordField(
                          title: "Urdu",
                          textDirection: TextDirection.rtl,
                          textEditingController: urduTextController,
                        ),
                        const SizedBox(height: 10),
                        WordField(
                          title: "English",
                          textDirection: TextDirection.ltr,
                          textEditingController: englishTextController,
                        ),
                        const SizedBox(height: 10),
                        WordField(
                          title: "Roman Balochi",
                          textDirection: TextDirection.ltr,
                          textEditingController: romanBalochiTextController,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            final balochi = balochiTextController.text.trim();
                            final urdu = urduTextController.text.trim();
                            final english = englishTextController.text.trim();
                            final romanBalochi =
                                romanBalochiTextController.text.trim();

                            if (balochi.isEmpty &&
                                urdu.isEmpty &&
                                english.isEmpty &&
                                romanBalochi.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    showCloseIcon: true,
                                    content: Text('One Word must be filled!')),
                              );
                              return;
                            }

                            Provider.of<UnverifiedWordsProvider>(context,
                                    listen: false)
                                .addUnverifiedWord(
                                    balochi, urdu, english, romanBalochi)
                                .then((_) {
                              if (context.mounted) {
                                balochiTextController.text = "";
                                urduTextController.text = "";
                                englishTextController.text = "";
                                romanBalochiTextController.text = "";

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Word added successfully!')),
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Add to Local Database',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(selected: 2),
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
              child: const Text('Add Word'),
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

  Future<dynamic> _showDownloadDialog(BuildContext context) {
    Map<String, dynamic> result = {
      "statusCode": 0,
    };
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<UnverifiedWordsProvider>(
              builder: (context, unverifiedWordsProvider, child) {
            return AlertDialog(
              title: const Text("Confirm Download"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Are you sure you to download all new words."),
                  const SizedBox(
                    height: 20,
                  ),
                  unverifiedWordsProvider.isDownloading
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Downloading..."),
                            LinearProgressIndicator(),
                          ],
                        )
                      : result["statusCode"] != 0
                          ? Text(result["body"])
                          : const SizedBox(),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Back"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      disabledBackgroundColor: primaryColor
                          .withBlue(150)
                          .withGreen(150)
                          .withRed(50)),
                  onPressed: !unverifiedWordsProvider.isDownloading
                      ? () async {
                          // Start animation
                          unverifiedWordsProvider.setIsDownloading(true);
                          // Start Downloading the data
                          result = await unverifiedWordsProvider
                              .getAllNewWordsFromServer();
                          // Stop animation
                          unverifiedWordsProvider.setIsDownloading(false);
                          // Show result of download
                          showGlobalSnackbar(result, primaryColor);
                        }
                      : null,
                  child: Text(
                    " Download ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              ],
            );
          });
        });
  }
}
