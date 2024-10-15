import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/components/global_snackbar.dart';
import 'package:rasaank_labzbalad/screens/unverified_words/word_list/provider.dart';
import 'package:rasaank_labzbalad/screens/unverified_words/word_list/word_tile/view.dart';
import 'package:rasaank_labzbalad/screens/word_list/search_field/view.dart';
import 'package:rasaank_labzbalad/themes/light_mode.dart';

class UnverifiedWordsList extends StatefulWidget {
  const UnverifiedWordsList({super.key});

  @override
  UnverifiedWordsListState createState() => UnverifiedWordsListState();
}

class UnverifiedWordsListState extends State<UnverifiedWordsList> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text =
        Provider.of<UnverifiedWordsProvider>(context, listen: false).searchText;
    Provider.of<UnverifiedWordsProvider>(context, listen: false)
        .getAllUnverifiedWords();
    textController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    String searchText = textController.text.toLowerCase();
    Provider.of<UnverifiedWordsProvider>(context, listen: false)
        .setSearchText(searchText);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnverifiedWordsProvider>(
        builder: (context, unverifiedWordsProvider, child) {
      TextDirection textDirection =
          unverifiedWordsProvider.selectedLanguage == "BL" ||
                  unverifiedWordsProvider.selectedLanguage == "UR"
              ? TextDirection.rtl
              : TextDirection.ltr;

      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          primary: true,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: SearchField(
              textController: textController,
              textDirection: textDirection,
              labelText: "Search Unverified Words",
              selectedItem: unverifiedWordsProvider.selectedLanguage,
              onLanguageChange: (newValue) {
                textController.text = "";
                unverifiedWordsProvider.setSelectedLanguage(newValue!);
              },
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: unverifiedWordsProvider.searchUnverifiedWords.length,
            itemBuilder: (context, index) {
              return UnverifiedWordTile(
                word: unverifiedWordsProvider.searchUnverifiedWords[index],
                textDirection: textDirection,
              );
            },
          ),
        ),
        floatingActionButton:
            _floatingActionButton(context, unverifiedWordsProvider),
        floatingActionButtonLocation: textDirection == TextDirection.rtl
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,
      );
    });
  }

  TextButton _floatingActionButton(
      BuildContext context, UnverifiedWordsProvider unverifiedWordsProvider) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        backgroundColor: primaryColor,
      ),
      onPressed: () {
        _showUploadDialog(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.upload,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Upload",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showUploadDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<UnverifiedWordsProvider>(
              builder: (context, unverifiedWordsProvider, child) {
            return AlertDialog(
              title: const Text("Confirm Upload"),
              content: unverifiedWordsProvider.unverifiedWordsLength > 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Are you sure you want to upload: "),
                        Text(
                          "Number of Words: ${unverifiedWordsProvider.unverifiedWordsLength.toString()}",
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        unverifiedWordsProvider.isUploading
                            ? const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Uploading..."),
                                  LinearProgressIndicator(),
                                ],
                              )
                            : const SizedBox()
                      ],
                    )
                  : const Text("There is nothing to upload!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Back"),
                ),
                unverifiedWordsProvider.unverifiedWordsLength > 0
                    ? TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            disabledBackgroundColor: primaryColor
                                .withBlue(150)
                                .withGreen(150)
                                .withRed(50)),
                        onPressed: !unverifiedWordsProvider.isUploading
                            ? () async {
                                // Start animation
                                unverifiedWordsProvider.setIsUploading(true);
                                // Start Uploading the data
                                Map<String, dynamic> result =
                                    await unverifiedWordsProvider
                                        .sendUnverifiedWordsToServer();
                                // Stop animation
                                unverifiedWordsProvider.setIsUploading(false);
                                // Show result of upload
                                showGlobalSnackbar(result, primaryColor);
                              }
                            : null,
                        child: Text(
                          " Upload ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : const SizedBox(width: 0),
              ],
            );
          });
        });
  }
}
