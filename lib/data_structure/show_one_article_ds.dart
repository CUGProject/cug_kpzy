import 'package:meta/meta.dart';
import 'dart:convert';
/*
一篇文章的数据结构，
包括标题，
正文，
时间作为id
 */
class Note {
  Note({
    @required this.title,
    @required this.text,
    @required this.date,
  });

  final String title;
  String text;
  final DateTime date;
  static List<Note> allFromResponse(String response) {//1
    var decodedJson = json.decode(response).cast<String, dynamic>();//2
    return decodedJson['results']
        .cast<Map<String, dynamic>>()
        .map((obj) => Note.fromMap(obj))//3
        .toList()
        .cast<Note>();//4
  }

  static Note fromMap(Map map) {
    var textJson = json.encode(map['text']);//5
    return new Note(//6
      title: map['title'],
      text: textJson,
      date: DateTime.parse(map['date']),//7
    );
  }
}

