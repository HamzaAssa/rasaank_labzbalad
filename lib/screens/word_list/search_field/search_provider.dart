import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/services/database_service.dart';

class SearchProvider extends ChangeNotifier {
  String _selectedLanguage = "EN";
  String _searchText = '';
  List<Map<String, dynamic>> _words = [];

  String get selectedLanguage => _selectedLanguage;
  String get searchText => _searchText;
  List<Map<String, dynamic>> get searchedWords => _words
      .where((word) => word["word"].toLowerCase().contains(searchText))
      .toList();

  void setSelectedDropdownValue(String newValue) {
    _selectedLanguage = newValue;
    notifyListeners();
  }

  void setSearchText(String newText) {
    _searchText = newText;
    notifyListeners();
  }

  Future<void> getAllWords() async {
    final DatabaseService databaseService = DatabaseService.instance;
    _words = await databaseService.getAllWords(_selectedLanguage);
    notifyListeners();
  }
}
