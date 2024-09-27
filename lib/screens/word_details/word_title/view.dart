import 'package:flutter/material.dart';

class WordTitle extends StatelessWidget {
  final String title;
  final String language;
  final TextDirection textDirection;
  const WordTitle(
      {super.key,
      required this.title,
      required this.language,
      required this.textDirection});

  @override
  Widget build(BuildContext context) {
    String lang = language;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              lang,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: textDirection == TextDirection.rtl ? 7 : 9),
            child: Text(
              title,
              textDirection: textDirection,
              style: TextStyle(
                fontSize: textDirection == TextDirection.rtl ? 20 : 18,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
