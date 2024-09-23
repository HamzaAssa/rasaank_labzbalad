import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _selectedDropdownValue = "EN";
  String _searchText = '';

  String get selectedDropdownValue => _selectedDropdownValue;
  String get searchText => _searchText;

  void setSelectedDropdownValue(String newValue) {
    _selectedDropdownValue = newValue;
    notifyListeners(); // Notify listeners of changes
  }

  void setSearchText(String newText) {
    _searchText = newText;
    notifyListeners(); // Notify listeners of changes
  }
}
