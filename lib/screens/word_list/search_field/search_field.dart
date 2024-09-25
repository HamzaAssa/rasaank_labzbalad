import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/screens/word_list/search_field/custom_dropdown.dart';

class SearchField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final TextDirection textDirection;
  final List<Map<String, String>> dropdownItems = const [
    {'value': "BL", 'text': "Balochi"},
    {'value': "EN", 'text': "English"},
    {'value': "UR", 'text': "Urdu"},
    {'value': "RB", 'text': "Roman Balochi"},
  ];
  final String selectedItem;
  final ValueChanged<String?> onLanguageChange;

  const SearchField({
    super.key,
    required this.textController,
    required this.textDirection,
    required this.hintText,
    required this.selectedItem,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            offset: const Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              textDirection: textDirection,
              cursorColor: primaryColor,
              style: TextStyle(
                color: primaryColor,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: primaryColor,
                ),
                hintText: hintText,
                // hintTextDirection: textDirection,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withAlpha(0)),
                ),
              ),
            ),
          ),
          CustomDropdown(
            onChanged: onLanguageChange,
            selectedItem: selectedItem,
          ),
        ],
      ),
    );
  }
}
