import 'package:ozan/db/journal_db/journal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import from sqflite_common_ffi
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dart:io' show Platform;

class JournalDBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDatabase();

    return _db;
  }

initDatabase() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;

    // Determine the correct directory based on the platform
    String databasesPath;
    
    if (Platform.isIOS || Platform.isAndroid) {
      // For mobile platforms
      final documentsDirectory = await getApplicationDocumentsDirectory();
      databasesPath = documentsDirectory.path;

    } else {
      // For other platforms (e.g., Windows)
      databasesPath = 'C:/ProgramData/Caira'; // Specify your custom directory path
    }

    final path = join(databasesPath, 'cairaDB.db');

    if(Platform.isAndroid || Platform.isIOS){

      _db = await openDatabase(path, version: 1, onCreate: _onCreate);

    }
    
    else {
        _db = await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          onCreate: _onCreate,
          version: 1,
        ),
      );
    }


    return _db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE journal (id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT NOT NULL, date DATE NOT NULL)');
  }

  Future<Journal> insert(Journal notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('journal', notesModel.toMap());
    return notesModel;
  }

  Future<List<Journal>> getNotesList() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult = await dbClient!.query('journal');

    return queryResult.map((e) => Journal.fromMap(e)).toList();
  }

  Future<int> delete(int? id) async {
    var dbClient = await db;
    return await dbClient!.delete('journal', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Journal notesModel) async {
    var dbClient = await db;
    return dbClient!.update(
      'journal',
      notesModel.toMap(),
      where: 'id = ?',
      whereArgs: [notesModel.id],
    );
  }


  Future<bool> check(String date) async {

    final dbClient = await db;

    final List<Map<String, dynamic>> maps = await dbClient!.query(
      'journal',
      where: 'date = ?',
      whereArgs: [date],
    );

    // Check if any entry exists for the given date
    return maps.isEmpty;
  }

}