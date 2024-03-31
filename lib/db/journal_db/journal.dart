class Journal{

  final int? id;

  final String description;

  final String date;

  Journal({this.id, required this.description, required this.date});

  Journal.fromMap(Map<String, dynamic> res):

  id = res['id'],

  description = res['description'],

  date = res['date'];

  Map<String, Object?> toMap(){

    return {

      'id' : id,

      'description' : description,

      'date' : date,
    };
  }

}