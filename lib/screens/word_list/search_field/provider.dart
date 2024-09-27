import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/services/database_service.dart';

class SearchProvider extends ChangeNotifier {
  String _selectedLanguage = "BL";
  String _searchText = '';
  List<Map<String, dynamic>> _balochiWords = [];
  List<Map<String, dynamic>> _urduWords = [];
  List<Map<String, dynamic>> _englishWords = [];
  List<Map<String, dynamic>> _romanBalochiWords = [];

  String get selectedLanguage => _selectedLanguage;
  String get searchText => _searchText;

  // Filter the words based on search text
  List<Map<String, dynamic>> get searchWords {
    List<Map<String, dynamic>> words = [];
    if (_selectedLanguage == "BL") {
      words = _balochiWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    } else if (_selectedLanguage == "UR") {
      words = _urduWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    } else if (_selectedLanguage == "EN") {
      words = _englishWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    } else if (_selectedLanguage == "RB") {
      words = _romanBalochiWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    }
    return words;
  }

  // Set the selected language
  void setSelectedLanguage(String newValue) {
    _selectedLanguage = newValue;
    notifyListeners();
  }

  // Set the search text
  void setSearchText(String newText) {
    _searchText = newText;
    notifyListeners();
  }

  // Get all words and save them to words
  Future<void> getAllWords() async {
    final DatabaseService databaseService = DatabaseService.instance;
    _balochiWords = await databaseService.getAllWords("BL");
    _englishWords = await databaseService.getAllWords("EN");
    _urduWords = await databaseService.getAllWords("UR");
    _romanBalochiWords = await databaseService.getAllWords("RB");
    notifyListeners();
  }
}
