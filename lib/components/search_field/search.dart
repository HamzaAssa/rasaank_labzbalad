import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/components/search_field/custom_dropdown.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color of the container
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.2), // Slightly transparent shadow color
            offset: const Offset(0, 0), // Position the shadow
            blurRadius: 6, // Softens the shadow
            spreadRadius: 1, // Expands the shadow
          ),
          BoxShadow(
            color: Colors.grey
                .withOpacity(0.1), // Slightly transparent shadow color
            offset: const Offset(0, 2), // Position the shadow
            blurRadius: 4, // Softens the shadow
            spreadRadius: 1, // Expands the shadow
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
              obscureText: false,
              controller: textController,
              textDirection: textDirection,
              cursorColor: Theme.of(context)
                  .colorScheme
                  .primary
                  .withGreen(100)
                  .withBlue(100),
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withBlue(100)
                      .withGreen(100)),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withGreen(100)
                        .withBlue(100)),
                hintText: hintText,
                hintTextDirection: textDirection,
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
