import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String selectedItem;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  String _selectedItem = "";

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  bool _isTapped = false;

  final List<Map<String, String>> dropdownItems = const [
    {'value': "BL", 'text': "Balochi"},
    {'value': "EN", 'text': "English"},
    {'value': "UR", 'text': "Urdu"},
    {'value': "RB", 'text': "Roman Balochi"},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        _showDropdown(context);
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: _isTapped
              ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
              : Colors.transparent,
          border: Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(
              color: !_isTapped
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                  : Colors.transparent,
              width: 2,
            ),
            bottom: BorderSide.none,
          ),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(0),
            right: Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            _selectedItem,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withGreen(100)
                  .withBlue(100),
            ),
          ),
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) async {
    final selected = await showMenu<String>(
      context: context,
      elevation: 10,
      position: const RelativeRect.fromLTRB(100, 0, 0, 0),
      items: dropdownItems.map((option) {
        return PopupMenuItem<String>(
          value: option["value"],
          child: SizedBox(
            child: Text(option["text"]!),
          ),
        );
      }).toList(),
    );
    if (selected != null) {
      setState(() {
        widget.onChanged(selected);
        _selectedItem = selected;
      });
    }
  }
}
