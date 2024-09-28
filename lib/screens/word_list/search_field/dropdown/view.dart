import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String selectedItem;
  final ValueChanged<String?> onChanged;
  final Color color;

  const CustomDropdown({
    super.key,
    required this.selectedItem,
    required this.onChanged,
    required this.color,
  });

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  String _selectedItem = "";

  @override
  void initState() {
    super.initState();
    if (widget.selectedItem == "BL") {
      _selectedItem = "Balochi";
    } else if (widget.selectedItem == "UR") {
      _selectedItem = "Urdu";
    } else if (widget.selectedItem == "EN") {
      _selectedItem = "English";
    } else if (widget.selectedItem == "UR") {
      _selectedItem = "R Balochi";
    }
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
        height: 30,
        padding: const EdgeInsets.only(left: 10, right: 5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color:
              _isTapped ? Theme.of(context).colorScheme.primary : widget.color,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                _selectedItem,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Icon(
                  _isTapped
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: Theme.of(context).colorScheme.onPrimary),
            ],
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
        if (selected == "BL") {
          _selectedItem = "Balochi";
        } else if (selected == "UR") {
          _selectedItem = "Urdu";
        } else if (selected == "EN") {
          _selectedItem = "English";
        } else if (selected == "UR") {
          _selectedItem = "R Balochi";
        }
      });
    }
  }
}
