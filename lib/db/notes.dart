
class NotesModel{

  final int? id;

  final String title;

  final String description;

  final String category;

  final String date;

  NotesModel({required this.title, this.id, required this.description, required this.category, required this.date});

  NotesModel.fromMap(Map<String, dynamic> res):

  id = res['id'],

  title = res['title'],

  description = res['description'],

  category = res['category'],

  date = res['date'];

  Map<String, Object?> toMap(){

    return {

      'id' : id,

      'title' : title,

      'description' : description,

      'category' : category,

      'date' : date,
    };
  }

}