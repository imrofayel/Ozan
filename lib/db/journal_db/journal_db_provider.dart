import 'package:flutter/material.dart';
import 'package:ozan/db/journal_db/journal_db_handler.dart';
import 'package:ozan/db/journal_db/journal.dart';

class JournalDatabaseProvider with ChangeNotifier{

  JournalDatabaseProvider(){
    initDatabase();
  }

  JournalDBHelper dbHelper = JournalDBHelper();

  late Future<List<Journal>> notesList;

  initDatabase() async{

    notesList = dbHelper.getNotesList();
    
    notifyListeners();
  }

  int length = 0;

  setLength() async{

    dbHelper.getNotesList().then((value) => length = value.length);

    notifyListeners();
  }

}