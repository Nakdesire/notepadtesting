class Note {
  late int _id;
  late String _title;
  late String _body;
  late String _date;

  Note(this._id, this._title, this._date, this._body);

  Note.withID(this._title, this._date, this._body);

  int get id => _id;
  String get title => _title;
  String get body => _body;
  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 200) {
      this._title = newTitle;
    }
  }

  set body(String newBody) {
    if (newBody.length <= 200) {
      this._body = newBody;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // convert Object to MAP to save in DB
  // SQFLITE saves and returns MAP only

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != 0) {
      map['id'] = this._id;
    }
    map['title'] = this._title;
    map['body'] = this._body;
    map['date'] = this._date;

    return map;
  }

  // extract note Object from MAP

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._body = map['body'];
    this._date = map['date'];
  }
}
