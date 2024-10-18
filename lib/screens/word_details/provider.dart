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

  Future<void> getWord({int? id, bool unverified = false}) async {
    // Reset the expanded
    setIsExapanded(false, "Balochi");
    setIsExapanded(false, "Urdu");
    setIsExapanded(false, "English");
    setIsExapanded(false, "Roman Balochi");

    final DatabaseService databaseService = DatabaseService.instance;
    List<Map<String, dynamic>> word;
    List<Map<String, dynamic>> definitions;
    List<Map<String, dynamic>> examples;
    (word, definitions, examples) = await databaseService
        .getWordWithMeaningAndDefinitions(wordId: id!, unverified: unverified);

    var balochiDefinitions = [];
    var urduDefinitions = [];
    var englishDefinitions = [];
    var romanBalochiDefinitions = [];

    for (var definition in definitions) {
      Map<String, dynamic> newDefinition = {
        "id": definition["id"],
        "definition": definition["definition"],
        "word_id": definition["word_id"],
        "examples": []
      };
      for (var example in examples) {
        if (example["definition_id"] == definition["id"]) {
          newDefinition["examples"].add(example);
        }
      }
      if (definition["word_id"] == word[0]["balochiId"]) {
        balochiDefinitions.add(newDefinition);
      } else if (definition["word_id"] == word[0]["urduId"]) {
        urduDefinitions.add(newDefinition);
      } else if (definition["word_id"] == word[0]["englishId"]) {
        englishDefinitions.add(newDefinition);
      } else if (definition["word_id"] == word[0]["romanBalochiId"]) {
        romanBalochiDefinitions.add(newDefinition);
      }
    }

    _word = {
      "balochi": {
        "id": word[0]["balochiId"],
        "word": word[0]["balochiWord"],
        "definitions": balochiDefinitions,
      },
      "urdu": {
        "id": word[0]["urduId"],
        "word": word[0]["urduWord"],
        "definitions": urduDefinitions,
      },
      "english": {
        "id": word[0]["englishId"],
        "word": word[0]["englishWord"],
        "definitions": englishDefinitions,
      },
      "romanBalochi": {
        "id": word[0]["romanBalochiId"],
        "word": word[0]["romanBalochiWord"],
        "definitions": romanBalochiDefinitions,
      }
    };
    // print('shit shit ${_word["english"]} $definitions');

    notifyListeners();
  }

  void setIsExapanded(bool value, String language) {
    _isExpanded[language] = value;
    notifyListeners();
  }
}
