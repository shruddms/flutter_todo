import 'dart:convert';

class Todo {
  String id;
  String title;
  String content;
  bool done;

  Todo({
    required this.id,
    required this.title,
    required this.content,
    this.done = false,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        done = json['done'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'done': done,
  };
}
