import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/services/database_service.dart';

class WordDetailsProvider with ChangeNotifier {
  Map<String, Map<String, dynamic>> _word = {};

  final Map<String, bool> _isExpanded = {
    "Balochi": false,
    "Urdu": false,
    "English": false,
    "Roman Balochi": false,
  };

  Map<String, dynamic> get word => _word;
  Map<String, bool> get isExpanded => _isExpanded;

  Future<void> getWord(int id) async {
    // Reset the expanded
    setIsExapanded(false, "Balochi");
    setIsExapanded(false, "Urdu");
    setIsExapanded(false, "English");
    setIsExapanded(false, "Roman Balochi");

    final DatabaseService databaseService = DatabaseService.instance;
    List<Map<String, dynamic>> word;
    List<Map<String, dynamic>> definations;
    List<Map<String, dynamic>> examples;
    (word, definations, examples) =
        await databaseService.getWordWithMeaningAndDefinations(id);

    var balochiDefinations = [];
    var urduDefinations = [];
    var englishDefinations = [];
    var romanBalochiDefinations = [];

    for (var defination in definations) {
      Map<String, dynamic> newDefination = {
        "id": defination["id"],
        "defination": defination["defination"],
        "word_id": defination["word_id"],
        "examples": []
      };
      for (var example in examples) {
        if (example["defination_id"] == defination["id"]) {
          newDefination["examples"].add(example);
        }
      }
      if (defination["word_id"] == word[0]["balochiId"]) {
        balochiDefinations.add(newDefination);
      } else if (defination["word_id"] == word[0]["urduId"]) {
        urduDefinations.add(newDefination);
      } else if (defination["word_id"] == word[0]["englishId"]) {
        englishDefinations.add(newDefination);
      } else if (defination["word_id"] == word[0]["romanBalochiId"]) {
        romanBalochiDefinations.add(newDefination);
      }
    }
    _word = {
      "balochi": {
        "id": word[0]["balochiId"],
        "word": word[0]["balochiWord"],
        "definations": balochiDefinations,
      },
      "urdu": {
        "id": word[0]["urduId"],
        "word": word[0]["urduWord"],
        "definations": urduDefinations,
      },
      "english": {
        "id": word[0]["englishId"],
        "word": word[0]["englishWord"],
        "definations": englishDefinations,
      },
      "romanBalochi": {
        "id": word[0]["romanBalochiId"],
        "word": word[0]["romanBalochiWord"],
        "definations": romanBalochiDefinations,
      }
    };

    notifyListeners();
  }

  void setIsExapanded(bool value, String language) {
    _isExpanded[language] = value;
    notifyListeners();
  }
}
