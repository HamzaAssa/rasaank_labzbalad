import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/services/database_service.dart';

class FavoriteProvider extends ChangeNotifier {
  String _selectedLanguage = "BL";
  String _searchText = '';
  List<Map<String, dynamic>> _balochiFavoriteWords = [];
  List<Map<String, dynamic>> _urduFavoriteWords = [];
  List<Map<String, dynamic>> _englishFavoriteWords = [];
  List<Map<String, dynamic>> _romanBalochiFavoriteWords = [];

  bool _isCurrentWordInFavorite = false;

  bool get isCurrentWordInFavorite => _isCurrentWordInFavorite;
  String get selectedLanguage => _selectedLanguage;
  String get searchText => _searchText;

// Set if the word is in favorite or not
  Future<void> findISFavoriteByWordId(int id) async {
    final DatabaseService databaseService = DatabaseService.instance;
    _isCurrentWordInFavorite = await databaseService.isFavorite(id);
    notifyListeners();
  }

// Add or Remove from favorites
  void updateFavorite(int id, bool value) async {
    final DatabaseService databaseService = DatabaseService.instance;
    _isCurrentWordInFavorite = !value;
    value
        ? await databaseService.removeFromFavorite(id)
        : await databaseService.addToFavorite(id);
    await getAllFavoriteWords();
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

  // Get all words and save them to words
  Future<void> getAllFavoriteWords() async {
    final DatabaseService databaseService = DatabaseService.instance;
    _balochiFavoriteWords = await databaseService.getAllFavoriteWords("BL");
    _englishFavoriteWords = await databaseService.getAllFavoriteWords("EN");
    _urduFavoriteWords = await databaseService.getAllFavoriteWords("UR");
    _romanBalochiFavoriteWords =
        await databaseService.getAllFavoriteWords("RB");
    notifyListeners();
  }

  // Filter the words based on search text
  List<Map<String, dynamic>> get searchFavoriteWords {
    List<Map<String, dynamic>> words = [];
    if (_selectedLanguage == "BL") {
      words = _balochiFavoriteWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          // word["search_word"].toLowerCase().contains(searchText),
          .toList();
    } else if (_selectedLanguage == "UR") {
      words = _urduFavoriteWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    } else if (_selectedLanguage == "EN") {
      words = _englishFavoriteWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    } else if (_selectedLanguage == "RB") {
      words = _romanBalochiFavoriteWords
          .where((word) => word["word"].toLowerCase().contains(searchText))
          .toList();
    }
    return words;
  }
}
