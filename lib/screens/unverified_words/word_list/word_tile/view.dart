import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/unverified_words/word_list/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/view.dart';

class UnverifiedWordTile extends StatelessWidget {
  final Map<String, dynamic> word;
  final TextDirection textDirection;

  const UnverifiedWordTile({
    super.key,
    required this.word,
    required this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);
    return Ink(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Consumer2<WordDetailsProvider, UnverifiedWordsProvider>(builder:
          (context, wordDetailsProvider, unverifiedWordProvider, child) {
        return InkWell(
          onTap: () async {
            await wordDetailsProvider.getWord(id: word["id"], unverified: true);
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WordDetails(word: word, fromUnverified: false),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(textDirection: textDirection, children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: primaryColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  word["word"].toString().isNotEmpty
                      ? word["word"].split("")[0]
                      : "",
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  textDirection: textDirection,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      word["word"]!,
                      style: const TextStyle(fontSize: 18),
                    ),
                    word["defination"] != null
                        ? Text(
                            word["defination"]!,
                            textDirection: textDirection,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  bool isUnverified = true;
                  return SizedBox(
                    width: 45,
                    height: 45,
                    child: IconButton(
                      onPressed: () async {
                        // wait for animation to complete
                        await Future.delayed(const Duration(milliseconds: 100));
                        // Update the provider
                        if (context.mounted) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Delete"),
                                  content: const Text(
                                    "Are you sure you want to delete this word?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: primaryColor,
                                      ),
                                      onPressed: () async {
                                        unverifiedWordProvider
                                            .deleteUnverified(word["id"]);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      isSelected: isUnverified,
                      selectedIcon: const Icon(Icons.delete_rounded),
                      icon: const Icon(Icons.delete_outline),
                      color: primaryColor,
                    ),
                  );
                },
              )
            ]),
          ),
        );
      }),
    );
  }
}
