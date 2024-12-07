import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class WordService {
  static Future<Map<String, dynamic>> getNewWordsFromServer(int version) async {
    // await Future.delayed(const Duration(milliseconds: 2000));
    // final url =
    //     Uri.parse('https://rasaanklabzbalad.gedrosia.tech/api/words/new')
    final url = Uri.parse('http://192.168.86.21:8000/api/words/new')
        .replace(queryParameters: {
      'version': '$version',
    });
// Send a Get request
    try {
      return await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'Messangers-Of-Gods-Hermes',
        },
      ).then((response) {
        var content = json.decode(response.body);
        return {
          "statusCode": response.statusCode,
          "body": content["text"],
          "words": content["words"],
          "definitions": content["definitions"],
          "examples": content["examples"],
          "wordRelations": content["wordRelations"],
          "newDBVersion": content["newDBVersion"],
        };
      });
      // var content = json.decode(seedList);
      // return {
      //   "statusCode": content["statusCode"],
      //   "body": content["text"],
      //   "words": content["words"],
      //   "definitions": content["definitions"],
      //   "examples": content["examples"],
      //   "wordRelations": content["wordRelations"],
      //   "newDBVersion": content["newDBVersion"],
      // };
    } catch (error) {
      return {
        "statusCode": 500,
        "body": 'An unexpected Error occurred.',
      };
    }
  }

  static Future<Map<String, dynamic>> sendNewDataToServer(
      words, relations) async {
    // await Future.delayed(const Duration(milliseconds: 2000));
    // final url =
    //     Uri.parse('https://rasaanklabzbalad.gedrosia.tech/api/words/add');
    final url = Uri.parse('http://192.168.86.21:8000/api/words/add');

    // Send a POST request
    try {
      return await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'Messangers-Of-Gods-Hermes',
        },
        body: json.encode({
          "words": words,
          "relations": relations
        }), // Convert the data to JSON
      )
          .then((response) {
        return {
          "statusCode": response.statusCode,
          "body": json.decode(response.body),
        };
      });
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
