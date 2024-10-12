import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/services/database_service.dart';

class UnverifiedWordsProvider extends ChangeNotifier {
  String _selectedLanguage = "BL";
  String _searchText = '';
  bool _isUploading = false;
  int _unverifiedWordsLength = 0;
  List<Map<String, dynamic>> _balochiUnverifiedWords = [];
  List<Map<String, dynamic>> _urduUnverifiedWords = [];
  List<Map<String, dynamic>> _englishUnverifiedWords = [];
  List<Map<String, dynamic>> _romanBalochiUnverifiedWords = [];

  String get selectedLanguage => _selectedLanguage;
  String get searchText => _searchText;
  bool get isUploading => _isUploading;
  int get unverifiedWordsLength => _unverifiedWordsLength;

  // Set uploading
  void setIsUploading(bool value) {
    _isUploading = value;
    notifyListeners();
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

  // Delete an unverified word
  void deleteUnverified(int id) async {
    final DatabaseService databaseService = DatabaseService.instance;
    await databaseService.deleteUnverifiedWord(id);
    await getAllUnverifiedWords();
    notifyListeners();
  }

  Future<void> addUnverifiedWord(
      String balochi, String urdu, String english, String romanBalochi) async {
    final DatabaseService databaseService = DatabaseService.instance;
    final word = {
      "balochiWord": {"word": balochi, "language": "BL"},
      "urduWord": {"word": urdu, "language": "UR"},
      "englishWord": {"word": english, "language": "EN"},
      "romanBalochiWord": {"word": romanBalochi, "language": "RB"},
    };

    await databaseService.addWordWithMeaning(word);
    notifyListeners();
  }

  // Get all words and save them to words
  Future<void> getAllUnverifiedWords() async {
    final DatabaseService databaseService = DatabaseService.instance;
    _balochiUnverifiedWords = await databaseService.getAllUnverfiedWords("BL");
    _englishUnverifiedWords = await databaseService.getAllUnverfiedWords("EN");
    _urduUnverifiedWords = await databaseService.getAllUnverfiedWords("UR");
    _romanBalochiUnverifiedWords =
        await databaseService.getAllUnverfiedWords("RB");
    _unverifiedWordsLength = _balochiUnverifiedWords.length +
        _englishUnverifiedWords.length +
        _urduUnverifiedWords.length +
        _romanBalochiUnverifiedWords.length;
    notifyListeners();
  }

  // Filter the words based on search text
  List<Map<String, dynamic>> get searchUnverifiedWords {
    List<Map<String, dynamic>> words = [];
    if (_selectedLanguage == "BL") {
      words = _balochiUnverifiedWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          // word["search_word"].toLowerCase().contains(searchText),
          .toList();
    } else if (_selectedLanguage == "UR") {
      words = _urduUnverifiedWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    } else if (_selectedLanguage == "EN") {
      words = _englishUnverifiedWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    } else if (_selectedLanguage == "RB") {
      words = _romanBalochiUnverifiedWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    }
    return words;
  }
}
