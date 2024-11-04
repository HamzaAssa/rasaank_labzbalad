import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class WordService {
  static const seedList = '''{
    "statusCode": 200,
    "text": "200 new words downloaded.",
    "words": [
      {"id": 1, "word": "کسمانک", "language": "BL"},
      {"id": 2, "word": "آزمانک", "language": "BL"},
      {"id": 3, "word": "لبزانک", "language": "BL"},
      {"id": 4, "word": "گدار", "language": "BL"},
      {"id": 5, "word": "گدارُک", "language": "BL"},
      {"id": 6, "word": "سرگوست", "language": "BL"},
      {"id": 7, "word": "تامر", "language": "BL"},
      {"id": 8, "word": "بامرد", "language": "BL"},
      {"id": 9, "word": "باجن", "language": "BL"},
      {"id": 10, "word": "وانگی", "language": "BL"},
      {"id": 11, "word": "دپتر", "language": "BL"},
      {"id": 12, "word": "ند", "language": "BL"},
      {"id": 13, "word": "ند نام", "language": "BL"},
      {"id": 14, "word": "دزنام", "language": "BL"},
      {"id": 15, "word": "پدنام", "language": "BL"},

      {"id": 16, "word": "ڈرامہ", "language": "UR"},
      {"id": 17, "word": "افسانہ", "language": "UR"},
      {"id": 18, "word": "ادب", "language": "UR"},
      {"id": 19, "word": "ناول", "language": "UR"},
      {"id": 20, "word": "ناولٹ", "language": "UR"},
      {"id": 21, "word": "آبیتی", "language": "UR"},
      {"id": 22, "word": "فلم", "language": "UR"},
      {"id": 23, "word": "ھیرو", "language": "UR"},
      {"id": 24, "word": "ھیرویٰن", "language": "UR"},
      {"id": 25, "word": "کتاب", "language": "UR"},
      {"id": 26, "word": "کاپی", "language": "UR"},
      {"id": 27, "word": "قلم", "language": "UR"},
      {"id": 28, "word": "قلمی نام", "language": "UR"},
      {"id": 29, "word": "دستخط", "language": "UR"},
      {"id": 30, "word": "لقب", "language": "UR"},

      {"id": 31, "word": "Drama", "language": "EN"},
      {"id": 32, "word": "Short Story", "language": "EN"},
      {"id": 33, "word": "Literature", "language": "EN"},
      {"id": 34, "word": "Novel", "language": "EN"},
      {"id": 35, "word": "Novelette", "language": "EN"},
      {"id": 36, "word": "Auto Biography", "language": "EN"},
      {"id": 37, "word": "Film", "language": "EN"},
      {"id": 38, "word": "Protagonist", "language": "EN"},
      {"id": 39, "word": "Heroine", "language": "EN"},
      {"id": 40, "word": "Book", "language": "EN"},
      {"id": 41, "word": "Note Book", "language": "EN"},
      {"id": 42, "word": "Pen", "language": "EN"},
      {"id": 43, "word": "Pen Name", "language": "EN"},
      {"id": 44, "word": "Signature", "language": "EN"},
      {"id": 45, "word": "Nickname", "language": "EN"},

      {"id": 46, "word": "Kasmaank", "language": "RB"},
      {"id": 47, "word": "Aazmank", "language": "RB"},
      {"id": 48, "word": "Labzaank", "language": "RB"},
      {"id": 49, "word": "Gedaar", "language": "RB"},
      {"id": 50, "word": "Gedaaruk", "language": "RB"},
      {"id": 51, "word": "Sar Gwast", "language": "RB"},
      {"id": 52, "word": "Taamur", "language": "RB"},
      {"id": 53, "word": "Baamard", "language": "RB"},
      {"id": 54, "word": "Baajan", "language": "RB"},
      {"id": 55, "word": "Waanagi", "language": "RB"},
      {"id": 56, "word": "Daptar", "language": "RB"},
      {"id": 57, "word": "Nad", "language": "RB"},
      {"id": 58, "word": "Nad Naam", "language": "RB"},
      {"id": 59, "word": "Daz Naam", "language": "RB"},
      {"id": 60, "word": "Pad Naam", "language": "RB"}
    ],
    "definitions": [
      {
        "id": 1,
        "definition":
            "A dramatic work intended for performance by actors on a stage",
        "word_id": 31
      },
      {
        "id": 2,
        "definition": "An episode that is turbulent or highly emotional",
        "word_id": 31
      },
      {
        "id": 3,
        "definition": "A prose narrative shorter than a novel",
        "word_id": 32
      },
      {
        "id": 4,
        "definition": "Creative writing of recognized artistic value",
        "word_id": 33
      },
      {
        "id": 5,
        "definition":
            "A written work or composition that has been published (printed on pages bound together)",
        "word_id": 40
      }
    ],
    "examples": [
      {
        "id": 1,
        "example": "he wrote several dramas but only one was produced on Broadway",
        "definition_id": 1
      },
      {
        "id": 2,
        "example": "I am reading a good book on economics",
        "definition_id": 5
      }
    ],
    "wordRelations": [
      {
        "balochi_id": 1,
        "urdu_id": 16,
        "english_id": 31,
        "roman_balochi_id": 46
      },
      {
        "balochi_id": 2,
        "urdu_id": 17,
        "english_id": 32,
        "roman_balochi_id": 47
      },
      {
        "balochi_id": 3,
        "urdu_id": 18,
        "english_id": 33,
        "roman_balochi_id": 48
      },
      {
        "balochi_id": 4,
        "urdu_id": 19,
        "english_id": 34,
        "roman_balochi_id": 49
      },
      {
        "balochi_id": 5,
        "urdu_id": 20,
        "english_id": 35,
        "roman_balochi_id": 50
      },
      {
        "balochi_id": 6,
        "urdu_id": 21,
        "english_id": 36,
        "roman_balochi_id": 51
      },
      {
        "balochi_id": 7,
        "urdu_id": 22,
        "english_id": 37,
        "roman_balochi_id": 52
      },
      {
        "balochi_id": 8,
        "urdu_id": 23,
        "english_id": 38,
        "roman_balochi_id": 53
      },
      {
        "balochi_id": 9,
        "urdu_id": 24,
        "english_id": 39,
        "roman_balochi_id": 54
      },
      {
        "balochi_id": 10,
        "urdu_id": 25,
        "english_id": 40,
        "roman_balochi_id": 55
      },
      {
        "balochi_id": 11,
        "urdu_id": 26,
        "english_id": 41,
        "roman_balochi_id": 56
      },
      {
        "balochi_id": 12,
        "urdu_id": 27,
        "english_id": 42,
        "roman_balochi_id": 57
      },
      {
        "balochi_id": 13,
        "urdu_id": 28,
        "english_id": 43,
        "roman_balochi_id": 58
      },
      {
        "balochi_id": 14,
        "urdu_id": 29,
        "english_id": 44,
        "roman_balochi_id": 59
      },
      {
        "balochi_id": 15,
        "urdu_id": 30,
        "english_id": 45,
        "roman_balochi_id": 60
      }
    ],
    "newDBVersion": 1
  }''';

  static Future<Map<String, dynamic>> getNewWordsFromServer(
      double version) async {
    // await Future.delayed(const Duration(milliseconds: 2000));
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
          'x-api-key': 'Messangers-Of-Gods-Hermes',
        },
      ).then((response) {
        var content = json.decode(response.body);
        return {
          "statusCode": content["statusCode"],
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

  static Future<Map<String, dynamic>> sendNewDataToServer(words) async {
    // await Future.delayed(const Duration(milliseconds: 2000));
    final url =
        Uri.parse('https://rasaanklabzbalad.gedrosia.tech/api/words/add');

    // Send a POST request
    try {
      return await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'Messangers-Of-Gods-Hermes',
        },
        body: json.encode(words), // Convert the data to JSON
      )
          .then((response) {
        return {
          "statusCode": response.statusCode,
          "body": response.body,
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
