
class NotesModel{

  final int? id;

  final String title;

  final String description;

  final String date;

  final int favourite;

  NotesModel({required this.title, this.id, required this.description, required this.date, required this.favourite});

  NotesModel.fromMap(Map<String, dynamic> res):

  id = res['id'],

  title = res['title'],

  description = res['description'],

  date = res['date'],

  favourite = res['favourite'];

  Map<String, Object?> toMap(){

    return {

      'id' : id,

      'title' : title,

      'description' : description,

      'date' : date,

      'favourite' : favourite
    };
  }

}