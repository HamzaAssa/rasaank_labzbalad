import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/services/database_service.dart';

class WordDetailsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _word = [];

  Map<String, dynamic> get word => _word[0];

  Future<void> getWord(int id) async {
    final DatabaseService databaseService = DatabaseService.instance;
    _word = await databaseService.getWordWithMeaningAndDefinations(id);
    print(_word);
    notifyListeners();
  }
}
