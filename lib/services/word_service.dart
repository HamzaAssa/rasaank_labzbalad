import 'package:share_plus/share_plus.dart';

class WordService {
  static Future<Map<String, dynamic>> getNewDataFromServer() async {
    return {
      "status": 0,
      "message": "Words downloaded successfully!",
      "content": [],
    };
  }

  static Future<Map<String, dynamic>> sendNewDataToServer() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    return {
      "status": 0,
      "message": "Words added successfully!",
    };
  }

  static void shareWord(String text) async {
    await Share.share(text);
  }
}
