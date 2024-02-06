import 'package:hive/hive.dart';
import 'package:to_do_app/model/todo.dart';

class HiveDatabase {
  final String boxName = 'todoBox';

  Future<void> addTodo(Todo todo) async {
    final box = await Hive.openBox<Todo>(boxName);
    box.add(todo);
  }

  Future<List<Todo>> getTodos() async {
    final box = await Hive.openBox<Todo>(boxName);
    return box.values.toList();
  }

  Future<Todo?> getTodoByIndex(int index) async {
    final box = await Hive.openBox<Todo>(boxName);
    return box.values.toList()[index];
  }

  Future<void> deleteTodo(int index) async {
    final box = await Hive.openBox<Todo>(boxName);
    await box.delete(index);
  }

  Future<void> updateTodo(int index, Todo todo) async {
    final box = await Hive.openBox<Todo>(boxName);
    await box.putAt(index, todo);
  }

  Future<void> updateStatus(int index, Todo todo) async {
    final box = await Hive.openBox<Todo>(boxName);
    todo.isDone = !todo.isDone;
    await box.put(index, todo);
  }
}

