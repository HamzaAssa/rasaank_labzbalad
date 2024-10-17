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
// Send a Get request
    try {
      return await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // return {
      //   "statusCode": 200,
      //   "body": "200 new words downloaded.",
      //   "words": [],
      //   "difinitions": [],
      //   "examples": [],
      //   "wordRelations": [],
      //   "newDBVersion": 2
      // };
    } catch (error) {
      return {
        "statusCode": 500,
        "body": 'An unexpected Error occurred.',
      };
    }
  }

  static Future<Map<String, dynamic>> sendNewDataToServer(words) async {
    await Future.delayed(const Duration(milliseconds: 5000));
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
      // return {
      //   "statusCode": 200,
      //   "body": "200 new words uploaded.",
      // };
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
