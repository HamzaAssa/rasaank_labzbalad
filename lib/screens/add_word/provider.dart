import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/services/database_service.dart';

class AddWordProvider with ChangeNotifier {
  Future<void> addWord(
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
}
