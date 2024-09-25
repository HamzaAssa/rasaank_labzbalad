import 'package:flutter/material.dart';

class WordField extends StatelessWidget {
  final String title;
  final TextDirection textDirection;
  final TextEditingController textEditingController;

  const WordField(
      {super.key,
      required this.title,
      required this.textDirection,
      required this.textEditingController});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(2.5)),
            ),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          TextField(
            controller: textEditingController,
            textDirection: textDirection,
            cursorColor: primaryColor,
            style: TextStyle(
              color: primaryColor,
            ),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: primaryColor,
              ),
              labelText: title,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(10.0),
              floatingLabelBehavior:
                  FloatingLabelBehavior.never, // Prevents label from floating
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withAlpha(0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
