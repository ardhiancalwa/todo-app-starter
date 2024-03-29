import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  bool isDone;

  Todo({
    required this.title,
    required this.description,
    this.isDone = false,
  });
}

List<Todo> todos = [
  Todo(title: 'Tes', description: 'Tes desc'),
  Todo(title: 'Tes 2', description: 'Tes desc 2'),
];
