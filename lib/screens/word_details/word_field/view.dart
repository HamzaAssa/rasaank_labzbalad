import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/provider.dart';

class WordField extends StatelessWidget {
  final Map<String, dynamic> word;
  final String language;
  final TextDirection textDirection;
  const WordField({
    super.key,
    required this.language,
    required this.textDirection,
    required this.word,
  });
  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withGreen(100).withBlue(100);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: primaryColor,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Consumer<WordDetailsProvider>(
          builder: (context, wordDetailsProvider, child) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(2)),
              ),
              child: Text(
                language,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: _word(primaryColor, wordDetailsProvider, context),
            ),
            wordDetailsProvider.isExpanded[language]!
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(
                        bottom: 5, left: 5, right: 5, top: 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _definations(primaryColor),
                    ),
                  )
                : const SizedBox(
                    width: 10,
                  ),
          ],
        );
      }),
    );
  }

  List<Widget> _definations(Color primaryColor) {
    List<Widget> list =
        word["definations"].asMap().entries.map<Widget>((entry) {
      var index = entry.key + 1;
      var defination = entry.value;
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Column(
              textDirection: textDirection,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$index: ${defination["defination"]}',
                  textDirection: textDirection,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Column(
                  children: defination["examples"].map<Widget>((example) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        textDirection: textDirection,
                        example["example"],
                      ),
                    );
                  }).toList(),
                ),
              ]),
        ),
      );
    }).toList();
    return list.isNotEmpty
        ? list
        : [
            const SizedBox(
              height: 15,
            )
          ];
  }

  _word(Color primaryColor, WordDetailsProvider wordDetailsProvider, context) {
    List<Widget> list = [
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: textDirection == TextDirection.rtl ? 7 : 9),
          child: Text(
            word["word"],
            textDirection: textDirection,
            style: TextStyle(
              fontSize: textDirection == TextDirection.rtl ? 20 : 18,
              color: primaryColor,
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        margin: const EdgeInsets.only(top: 20, bottom: 2),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: wordDetailsProvider.isExpanded[language]!
              ? primaryColor
              : Colors.transparent,
          textStyle: TextStyle(
            color: wordDetailsProvider.isExpanded[language]!
                ? Theme.of(context).colorScheme.onPrimary
                : primaryColor,
          ),
          child: InkWell(
            splashColor: Theme.of(context).colorScheme.secondary,
            highlightColor: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            onTap: () {
              wordDetailsProvider.setIsExapanded(
                  !wordDetailsProvider.isExpanded[language]!, language);
            },
            child: Row(
              children: [
                Icon(
                  wordDetailsProvider.isExpanded[language]!
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: wordDetailsProvider.isExpanded[language]!
                      ? Theme.of(context).colorScheme.onPrimary
                      : primaryColor,
                ),
                const Text(
                  "Defination",
                ),
                const SizedBox(width: 5)
              ],
            ),
          ),
        ),
      )
    ];
    if (textDirection == TextDirection.rtl) {
      list = list.reversed.toList();
    }
    return list;
  }
}
