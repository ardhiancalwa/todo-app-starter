import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo.dart';

class ItemTodo extends StatelessWidget {
  final Todo todo;
  final Function(bool?) onCheck;
  final Function() onEdit;
  final Function() onDelete;
  const ItemTodo({
    super.key,
    required this.todo,
    required this.onCheck,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    print("Todo Title: ${todo.title}, isDone: ${todo.isDone}");
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (value) => onCheck(value),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          todo.description,
          style: TextStyle(
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Row(
          children: [
            GestureDetector(
              onTap: onEdit,
              child: Icon(Icons.edit),
            ),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
