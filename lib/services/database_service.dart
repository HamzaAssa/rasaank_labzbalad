import 'package:path/path.dart';
import 'package:rasaank_labzbalad/services/db_tables/unverified_tables/unverified_definitions.dart';
import 'package:rasaank_labzbalad/services/db_tables/unverified_tables/unverified_examples.dart';
import 'package:rasaank_labzbalad/services/db_tables/verfied_tables/definitions.dart';
import 'package:rasaank_labzbalad/services/db_tables/verfied_tables/examples.dart';
import 'package:rasaank_labzbalad/services/db_tables/verfied_tables/favorites.dart';
import 'package:rasaank_labzbalad/services/db_tables/unverified_tables/unverified_word_to_word.dart';
import 'package:rasaank_labzbalad/services/db_tables/unverified_tables/unverified_words.dart';
import 'package:rasaank_labzbalad/services/db_tables/verfied_tables/words.dart';
import 'package:rasaank_labzbalad/services/db_tables/verfied_tables/word_to_word.dart';
import 'package:rasaank_labzbalad/services/word_service.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _db;

  DatabaseService._constructor();

  // Get database
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  // Create database
  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE ${Words.tableName} (
          ${Words.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Words.word} TEXT NOT NULL,
          ${Words.language} TEXT NOT NULL
        )
      ''');
        await db.execute('''
        CREATE TABLE ${WordToWord.tableName} (
          ${WordToWord.id} INTEGER PRIMARY KEY AUTOINCREMENT,
           ${WordToWord.balochiId} INTEGER,
          ${WordToWord.urduId} INTEGER,
          ${WordToWord.englishId} INTEGER,
          ${WordToWord.romanBalochiId} INTEGER,
          FOREIGN KEY(${WordToWord.balochiId}) REFERENCES ${Words.tableName}(${Words.id}) ON DELETE CASCADE,
          FOREIGN KEY(${WordToWord.urduId}) REFERENCES ${Words.tableName}(${Words.id}) ON DELETE CASCADE,
          FOREIGN KEY(${WordToWord.englishId}) REFERENCES ${Words.tableName}(${Words.id}) ON DELETE CASCADE,
          FOREIGN KEY(${WordToWord.romanBalochiId}) REFERENCES ${Words.tableName}(${Words.id}) ON DELETE CASCADE
        )
        ''');
        await db.execute('''
        CREATE TABLE ${Definitions.tableName} (
          ${Definitions.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Definitions.definition} TEXT NOT NULL,
          ${Definitions.wordId} INTEGER NOT NULL,
          FOREIGN KEY(${Definitions.wordId}) REFERENCES ${Words.tableName}(${Words.id}) ON DELETE CASCADE
        )
        ''');
        await db.execute('''
        CREATE TABLE ${Examples.tableName} (
          ${Examples.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Examples.example} TEXT NOT NULL,
          ${Examples.definitionId} INTEGER NOT NULL,
          FOREIGN KEY(${Examples.definitionId}) REFERENCES ${Definitions.tableName}(${Definitions.id}) ON DELETE CASCADE

        )
        ''');
        await db.execute('''
        CREATE TABLE ${UnverifiedWords.tableName} (
          ${UnverifiedWords.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${UnverifiedWords.word} TEXT NOT NULL,
          ${UnverifiedWords.language} TEXT NOT NULL
        )
        ''');
        await db.execute('''
        CREATE TABLE ${UnverifiedWordToWord.tableName} (
          ${UnverifiedWordToWord.id} INTEGER PRIMARY KEY AUTOINCREMENT,
           ${UnverifiedWordToWord.balochiId} INTEGER,
          ${UnverifiedWordToWord.urduId} INTEGER,
          ${UnverifiedWordToWord.englishId} INTEGER,
          ${UnverifiedWordToWord.romanBalochiId} INTEGER,
          FOREIGN KEY(${UnverifiedWordToWord.balochiId}) REFERENCES ${UnverifiedWords.tableName}(${UnverifiedWords.id}) ON DELETE CASCADE,
          FOREIGN KEY(${UnverifiedWordToWord.urduId}) REFERENCES ${UnverifiedWords.tableName}(${UnverifiedWords.id}) ON DELETE CASCADE,
          FOREIGN KEY(${UnverifiedWordToWord.englishId}) REFERENCES ${UnverifiedWords.tableName}(${UnverifiedWords.id}) ON DELETE CASCADE,
          FOREIGN KEY(${UnverifiedWordToWord.romanBalochiId}) REFERENCES ${UnverifiedWords.tableName}(${UnverifiedWords.id}) ON DELETE CASCADE
        )
        ''');
        await db.execute('''
        CREATE TABLE ${UnverifiedDefinitions.tableName} (
          ${UnverifiedDefinitions.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${UnverifiedDefinitions.definition} TEXT NOT NULL,
          ${UnverifiedDefinitions.wordId} INTEGER NOT NULL,
          FOREIGN KEY(${UnverifiedDefinitions.wordId}) REFERENCES ${UnverifiedWords.tableName}(${UnverifiedWords.id}) ON DELETE CASCADE
        )
        ''');
        await db.execute('''
        CREATE TABLE ${UnverifiedExamples.tableName} (
          ${UnverifiedExamples.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${UnverifiedExamples.example} TEXT NOT NULL,
          ${UnverifiedExamples.definitionId} INTEGER NOT NULL,
          FOREIGN KEY(${UnverifiedExamples.definitionId}) REFERENCES ${UnverifiedDefinitions.tableName}(${UnverifiedDefinitions.id}) ON DELETE CASCADE
        )
        ''');
        await db.execute('''
        CREATE TABLE ${Favorites.tableName} (
          ${Favorites.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Favorites.wordId} INTEGER NOT NULL,
          FOREIGN KEY(${Favorites.wordId}) REFERENCES ${Words.tableName}(${Favorites.id}) ON DELETE CASCADE

        )
        ''');
        await db.execute('''
        CREATE TABLE settings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          word_list_version INTEGER NOT NULL
        )
        ''');
        await db.insert("settings", {"word_list_version": 0});
        seeder();
      },
    );

    return database;
  }

  // Get all words with meanings and one definition
  Future<List<Map<String, dynamic>>> getAllWords(String language) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
      w.${Words.id} AS id,
      w.${Words.word} AS word,
      w.${Words.language} AS language,
      d.${Definitions.definition} AS definition 
      FROM ${Words.tableName} w 
      LEFT JOIN ${Definitions.tableName} d ON 
      d.${Definitions.wordId} = w.${Words.id}
      WHERE w.${Words.language} = ?
      GROUP BY w.${Words.id}
    ''', [language]);
  }

  // Get all unverified words with meanings and one definition
  Future<List<Map<String, dynamic>>> getAllUnverifiedWords(
    String language,
  ) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
      w.${UnverifiedWords.id} AS id,
      w.${UnverifiedWords.word} AS word,
      w.${UnverifiedWords.language} AS language,
      d.${UnverifiedDefinitions.definition} AS definition 
      FROM ${UnverifiedWords.tableName} w 
      LEFT JOIN ${UnverifiedDefinitions.tableName} d ON 
      d.${UnverifiedDefinitions.wordId} = w.${Words.id}
      WHERE w.${UnverifiedWords.language} = ? AND w.${UnverifiedWords.word} != ""
      GROUP BY w.${UnverifiedWords.id}
    ''', [language]);
  }

  Future<List<Map<String, dynamic>>> getAllUnverifiedRelations() async {
    final db = await database;
    return await db.query(UnverifiedWordToWord.tableName);
  }

  // Get single word with meaning, definitions, examples
  Future<
          (
            List<Map<String, Object?>>,
            List<Map<String, Object?>>,
            List<Map<String, dynamic>>
          )>
      getWordWithMeaningAndDefinitions(
          {required int wordId, unverified = false}) async {
    final db = await database;

    String wordTableName = Words.tableName;
    String wordToWordTableName = WordToWord.tableName;
    if (unverified) {
      wordTableName = UnverifiedWords.tableName;
      wordToWordTableName = UnverifiedWordToWord.tableName;
    }
    final result = await db.rawQuery('''
      SELECT 
      w1.${Words.id} AS balochiId,
      w2.${Words.id} AS urduId,
      w3.${Words.id} AS englishId,
      w4.${Words.id} AS romanBalochiId,
      w1.${Words.word} AS balochiWord,
      w2.${Words.word} AS urduWord,
      w3.${Words.word} AS englishWord,
      w4.${Words.word} AS romanBalochiWord
      FROM 
      $wordToWordTableName wtw
      LEFT JOIN $wordTableName w1 ON wtw.${WordToWord.balochiId} = w1.${Words.id}
      LEFT JOIN $wordTableName w2 ON wtw.${WordToWord.urduId} = w2.${Words.id}
      LEFT JOIN $wordTableName w3 ON wtw.${WordToWord.englishId} = w3.${Words.id}
      LEFT JOIN $wordTableName w4 ON wtw.${WordToWord.romanBalochiId} = w4.${Words.id}
      WHERE
      wtw.${WordToWord.balochiId} = ? OR wtw.${WordToWord.urduId} = ? 
      OR wtw.${WordToWord.englishId} = ? OR wtw.${WordToWord.romanBalochiId} = ?
      LIMIT 1
    ''', [wordId, wordId, wordId, wordId]);
    final List<Map<String, Object?>> definitions = await db.rawQuery(
      'SELECT * FROM ${Definitions.tableName} WHERE ${Definitions.wordId} IN (?, ?, ?, ?)',
      [
        int.parse(result[0]["balochiId"].toString()),
        int.parse(result[0]["urduId"].toString()),
        int.parse(result[0]["englishId"].toString()),
        int.parse(result[0]["romanBalochiId"].toString())
      ],
    );

    List<int> definitionIds =
        definitions.map((def) => def[Definitions.id] as int).toList();

    final placeholders =
        List.generate(definitionIds.length, (index) => '?').join(', ');
    final String sql =
        'SELECT * FROM ${Examples.tableName} WHERE ${Examples.definitionId} IN ($placeholders)';

    final List<Map<String, dynamic>> examples =
        await db.rawQuery(sql, definitionIds);

    return (result, definitions, examples);
  }

  // Add a single unverified word with meanings
  Future<int> addWordWithMeaning(Map word) async {
    final db = await database;

    // Insert the word into the Words table
    int balochiId =
        await db.insert(UnverifiedWords.tableName, word["balochiWord"]);
    int urduId = await db.insert(UnverifiedWords.tableName, word["urduWord"]);
    int englishId =
        await db.insert(UnverifiedWords.tableName, word["englishWord"]);
    int romanBalochiId =
        await db.insert(UnverifiedWords.tableName, word["romanBalochiWord"]);

    // Add the relationship
    int id = await db.insert(UnverifiedWordToWord.tableName, {
      UnverifiedWordToWord.balochiId: balochiId,
      UnverifiedWordToWord.urduId: urduId,
      UnverifiedWordToWord.englishId: englishId,
      UnverifiedWordToWord.romanBalochiId: romanBalochiId,
    });
    return id;
  }

  // Delete a single Unverified word
  Future<int> deleteUnverifiedWord(int wordId) async {
    final db = await database;
    // Update the word to be empty the only the word and not related ones from unverified words table
    return await db.update(
        UnverifiedWords.tableName, {UnverifiedWords.word: ""},
        where: '''${UnverifiedWords.id} = ? ''', whereArgs: [wordId]);
  }

  // Find wether word is in favorite
  Future<bool> isFavorite(int wordId) async {
    final db = await database;
    final results = await db.query(Favorites.tableName,
        where: '${Favorites.wordId} = ?', whereArgs: [wordId]);
    return results.isNotEmpty;
  }

  // Add word to favorite
  Future<int> addToFavorite(int wordId) async {
    final db = await database;
    final results =
        await db.insert(Favorites.tableName, {Favorites.wordId: wordId});
    return results;
  }

  // Remove word from favorite
  Future<int> removeFromFavorite(int wordId) async {
    final db = await database;
    return await db.delete(Favorites.tableName,
        where: '${Favorites.wordId} = ?', whereArgs: [wordId]);
  }

// Get all favorites words with meanings and one definition
  Future<List<Map<String, dynamic>>> getAllFavoriteWords(
      String language) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
      w.${Words.id} AS id,
      w.${Words.word} AS word,
      w.${Words.language} AS language,
      d.${Definitions.definition} AS definition 
      FROM ${Words.tableName} w 
      LEFT JOIN ${Definitions.tableName} d ON 
      d.${Definitions.wordId} = w.${Words.id}
          JOIN ${Favorites.tableName} f ON 
      f.${Favorites.wordId} = w.${Words.id}
      WHERE w.${Words.language} = ?
      GROUP BY w.${Words.id}
    ''', [language]);
  }

  Future<int> getWordListVersion() async {
    final db = await database;
    List<Map> result = await db.query("settings");
    return result[0]["word_list_version"];
  }

  // update Database with new Words
  Future<int> updateDBWithDownlaodedData(Map<String, dynamic> data) async {
    final db = await database;

    Batch batch = db.batch();
    for (var row in data["words"]) {
      batch.insert(
        Words.tableName,
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    for (var row in data["definitions"]) {
      batch.insert(
        Definitions.tableName,
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    for (var row in data["examples"]) {
      batch.insert(
        Examples.tableName,
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    for (var row in data["wordRelations"]) {
      batch.insert(
        WordToWord.tableName,
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    batch.update(
      "settings",
      {
        "word_list_version": data["newDBVersion"],
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
    return 1;
  }

  // Seeder
  Future<void> seeder() async {
    int version = await getWordListVersion();
    var result = await WordService.getNewWordsFromServer(version);
    if (result["statusCode"] != 500 && result["words"].length > 0) {
      await updateDBWithDownlaodedData(result);
    }
  }
}
