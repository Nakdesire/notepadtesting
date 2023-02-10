class Note {
  final int? id;
  final String title;
  final String body;
  final String date;

  Note({this.id, required this.title, required this.body, required this.date});

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'date': date,
      };
}
