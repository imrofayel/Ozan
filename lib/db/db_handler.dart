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
        'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, date TEXT NOT NULL, favourite INTEGER, tag TEXT NOT NULL)');
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

  Future<Map<String, List<NotesModel>>> searchNotes(String query) async {
    final Database? dbClient = await db;
    final List<Map<String, dynamic>> titleMaps = await dbClient!.query(
      'notes',
      where: "title LIKE ?",
      whereArgs: ['%$query%'],
    );

    final List<Map<String, dynamic>> descriptionMaps = await dbClient.query(
      'notes',
      where: "description LIKE ?",
      whereArgs: ['%$query%'],
    );

    Map<String, List<NotesModel>> results = {
      'title': List.generate(titleMaps.length, (i) {
        return NotesModel(
          id: titleMaps[i]['id'],
          title: titleMaps[i]['title'],
          description: titleMaps[i]['description'],
          date: titleMaps[i]['date'],
          favourite: titleMaps[i]['favourite'],
          tag: titleMaps[i]['tag']
        );
      }),
      'description': List.generate(descriptionMaps.length, (i) {
        return NotesModel(
          id: descriptionMaps[i]['id'],
          title: descriptionMaps[i]['title'],
          description: descriptionMaps[i]['description'],
          date: descriptionMaps[i]['date'],
          favourite: descriptionMaps[i]['favourite'],
          tag: descriptionMaps[i]['tag']
        );
      }),
    };

    return results;
  }  
}