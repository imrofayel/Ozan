import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import from sqflite_common_ffi
import 'package:path_provider/path_provider.dart';
import 'package:ozan/db/notes.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dart:io' show Platform;

class DBHelper {
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
      databasesPath = 'C:/ProgramData/Ozan'; // Specify your custom directory path
    }

    final path = join(databasesPath, 'notesDB.db');

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
        'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, date TEXT NOT NULL, favourite INTEGER)');
  }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('notes', notesModel.toMap());
    return notesModel;
  }

  Future<List<NotesModel>> getNotesList() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult = await dbClient!.query('notes');

    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future<int> delete(int? id) async {
    var dbClient = await db;
    return await dbClient!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(NotesModel notesModel) async {
    var dbClient = await db;
    return dbClient!.update(
      'notes',
      notesModel.toMap(),
      where: 'id = ?',
      whereArgs: [notesModel.id],
    );
  }


  Future<List<NotesModel>> searchNotes(String key) async {
    final Database? dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query(
      'notes',
      where: "title LIKE ? OR description LIKE ?",
      whereArgs: ['%$key%', '%$key%'],
    );

    return List.generate(maps.length, (i) {
      return NotesModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        date: maps[i]['date'],
        favourite: maps[i]['favourite']
      );
    });
  }
}