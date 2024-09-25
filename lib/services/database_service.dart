import 'package:path/path.dart';
import 'package:rasaank_labzbalad/services/db_tables/definations.dart';
import 'package:rasaank_labzbalad/services/db_tables/examples.dart';
import 'package:rasaank_labzbalad/services/db_tables/word_to_word.dart';
import 'package:rasaank_labzbalad/services/db_tables/words.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _db;

  DatabaseService._constructor();
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

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
        CREATE TABLE ${Definations.tableName} (
          ${Definations.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Definations.defination} TEXT NOT NULL,
          ${Definations.wordId} INTEGER NOT NULL,
          FOREIGN KEY(${Definations.wordId}) REFERENCES ${Words.tableName}(${Words.id}) ON DELETE CASCADE
        )
        ''');
        await db.execute('''
        CREATE TABLE ${Examples.tableName} (
          ${Examples.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Examples.example} TEXT NOT NULL,
          ${Examples.definationId} INTEGER NOT NULL,
          FOREIGN KEY(${Examples.definationId}) REFERENCES ${Definations.tableName}(${Definations.id}) ON DELETE CASCADE

        )
        ''');
      },
    );
    return database;
  }

  Future<List<Map<String, dynamic>>> getAllWords(String language) async {
    final db = await database;
    return await db.query(Words.tableName,
        where: "${Words.language} = ?", whereArgs: [language]);
  }

  Future<List<Map<String, dynamic>>> getWordWithMeaningAndDefinations(
      int wordId) async {
    final db = await database;

    // Query to join Words, Definations, and Examples, including related words
    final result = await db.rawQuery('''
    SELECT 
      w.${Words.id} AS word_id,
      w.${Words.word} AS word,
      rw.${Words.word} AS related_word,
      d.${Definations.id} AS defination_id,
      d.${Definations.defination} AS defination,
      e.${Examples.id} AS example_id,
      e.${Examples.example} AS example
    FROM ${Words.tableName} w
    LEFT JOIN ${WordToWord.tableName} wtw ON w.${Words.id} = wtw.${WordToWord.balochiId} OR w.${Words.id} = wtw.${WordToWord.urduId} OR w.${Words.id} = wtw.${WordToWord.englishId} OR w.${Words.id} = wtw.${WordToWord.romanBalochiId}
    LEFT JOIN ${Words.tableName} rw ON 
      rw.${Words.id} = wtw.${WordToWord.urduId} OR 
      rw.${Words.id} = wtw.${WordToWord.balochiId} OR 
      rw.${Words.id} = wtw.${WordToWord.englishId} OR 
      rw.${Words.id} = wtw.${WordToWord.romanBalochiId}
    LEFT JOIN ${Definations.tableName} d ON rw.${Words.id} = d.${Definations.wordId}
    LEFT JOIN ${Examples.tableName} e ON d.${Definations.id} = e.${Examples.definationId}
    WHERE w.${Words.id} = ?
  ''', [wordId]);

    return result;
  }

  Future<int> addWordWithMeaning(Map word) async {
    final db = await database;
    // Insert the word into the Words table
    await db.insert(Words.tableName, word["balochiWord"]);
    await db.insert(Words.tableName, word["urduWord"]);
    await db.insert(Words.tableName, word["englishWord"]);
    int romanBalochiWord =
        await db.insert(Words.tableName, word["romanBalochiWord"]);
    return romanBalochiWord;
  }
}
