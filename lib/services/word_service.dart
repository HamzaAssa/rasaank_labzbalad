import 'dart:convert';

import 'package:share_plus/share_plus.dart';

class WordService {
  static get http => null;

  static Future<Map<String, dynamic>> getNewWordsFromServer(
      double version) async {
    await Future.delayed(const Duration(milliseconds: 5000));
    final url =
        Uri.parse('https://rasaanklabzbalad.gedrosia.tech/api/words/new')
            .replace(queryParameters: {
      'version': '$version',
    });
    print(url);
// Send a Get request
    try {
      return await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (error) {
      return {
        "statusCode": 500,
        "body": 'An unexpected Error occurred.',
      };
    }
  }

  static Future<Map<String, dynamic>> sendNewDataToServer(words) async {
    final url =
        Uri.parse('https://rasaanklabzbalad.gedrosia.tech/api/words/add');

    // Send a POST request
    try {
      return await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(words), // Convert the data to JSON
      );
    } catch (error) {
      return {
        "statusCode": 500,
        "body": 'An unexpected Error occurred.',
      };
    }
  }

  static void shareWord(String text) async {
    await Share.share(text);
  }
}
