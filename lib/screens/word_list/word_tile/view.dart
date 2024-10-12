import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/favorites/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/view.dart';

class WordTile extends StatelessWidget {
  final Map<String, dynamic> word;
  final TextDirection textDirection;

  const WordTile({
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
      child: Consumer2<WordDetailsProvider, FavoriteProvider>(
          builder: (context, wordDetailsProvider, favoriteProvider, child) {
        return InkWell(
          onTap: () async {
            await wordDetailsProvider.getWord(id: word["id"]);
            await favoriteProvider.findISFavoriteByWordId(word["id"]);
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WordDetails(word: word),
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
                  word["word"].split("")[0],
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
            ]),
          ),
        );
      }),
    );
  }
}
