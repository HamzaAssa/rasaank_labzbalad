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

// Get all words with one definations
  Future<List<Map<String, dynamic>>> getAllWords(String language) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
      w.${Words.id} AS id,
      w.${Words.word} AS word,
      w.${Words.language} AS language,
      d.${Definations.defination} AS defination 
      FROM ${Words.tableName} w 
      LEFT JOIN ${Definations.tableName} d ON 
      w.${Words.id} = d.${Definations.wordId}
      WHERE w.${Words.language} = ?
    ''', [language]);
  }

// Get single word with meaning and definations
  Future<
      (
        List<Map<String, Object?>>,
        List<Map<String, Object?>>,
        List<Map<String, dynamic>>
      )> getWordWithMeaningAndDefinations(int wordId) async {
    final db = await database;

    final result = await db.rawQuery('''
      SELECT 
      w1.${Words.id} AS balochiId,
      w1.${Words.word} AS balochiWord,
      w2.${Words.id} AS urduId,
      w2.${Words.word} AS urduWord,
      w3.${Words.id} AS englishId,
      w3.${Words.word} AS englishWord,
      w4.${Words.id} AS romanBalochiId,
      w4.${Words.word} AS romanBalochiWord
      FROM 
      ${WordToWord.tableName} wtw
      LEFT JOIN ${Words.tableName} w1 ON wtw.${WordToWord.balochiId} = w1.${Words.id}
      LEFT JOIN ${Words.tableName} w2 ON wtw.${WordToWord.urduId} = w2.${Words.id}
      LEFT JOIN ${Words.tableName} w3 ON wtw.${WordToWord.englishId} = w3.${Words.id}
      LEFT JOIN ${Words.tableName} w4 ON wtw.${WordToWord.romanBalochiId} = w4.${Words.id}
      WHERE
      wtw.${WordToWord.balochiId} = ? OR wtw.${WordToWord.urduId} = ? 
      OR wtw.${WordToWord.englishId} = ? OR wtw.${WordToWord.romanBalochiId} = ?
      LIMIT 1
    ''', [wordId, wordId, wordId, wordId]);

    final List<Map<String, Object?>> definations = await db.rawQuery(
      'SELECT * FROM ${Definations.tableName} WHERE ${Definations.wordId} IN (?, ?, ?, ?)',
      [
        int.parse(result[0]["balochiId"].toString()),
        int.parse(result[0]["urduId"].toString()),
        int.parse(result[0]["englishId"].toString()),
        int.parse(result[0]["romanBalochiId"].toString())
      ],
    );

    List<int> definitionIds =
        definations.map((def) => def[Definations.id] as int).toList();

    final placeholders =
        List.generate(definitionIds.length, (index) => '?').join(', ');

    final String sql =
        'SELECT * FROM ${Examples.tableName} WHERE ${Examples.definationId} IN ($placeholders)';

    final List<Map<String, dynamic>> examples =
        await db.rawQuery(sql, definitionIds);

    return (result, definations, examples);
  }

// Add Single word with meanings
  Future<int> addWordWithMeaning(Map word) async {
    final db = await database;
    // await db.insert("definations", {
    //   "defination": "Bachak naren insan ah gushan.",
    //   "word_id": 4,
    // });
    // await db.insert("definations", {
    //   "defination": "Bachak naren insan ah gushan 2.",
    //   "word_id": 4,
    // });
    // await db.insert("definations", {
    //   "defination": "Jene madagen insan ah gushan.",
    //   "word_id": 8,
    // });
    // await db.insert("examples", {
    //   "example": "Umar yak bachake.",
    //   "defination_id": 1,
    // });
    // await db.insert("examples", {
    //   "example": "Umar yak bachake 2.",
    //   "defination_id": 2,
    // });

    // Insert the word into the Words table
    int balochiId = await db.insert(Words.tableName, word["balochiWord"]);
    int urduId = await db.insert(Words.tableName, word["urduWord"]);
    int englishId = await db.insert(Words.tableName, word["englishWord"]);
    int romanBalochiId =
        await db.insert(Words.tableName, word["romanBalochiWord"]);

    // Add the relationship
    int id = await db.insert(WordToWord.tableName, {
      WordToWord.balochiId: balochiId,
      WordToWord.urduId: urduId,
      WordToWord.englishId: englishId,
      WordToWord.romanBalochiId: romanBalochiId,
    });
    return id;
  }
}
