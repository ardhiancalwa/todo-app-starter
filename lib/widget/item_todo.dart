import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo.dart';

class ItemTodo extends StatelessWidget {
  final Todo todo;
  final Function(bool?) onCheck;
  final Function() onEdit;
  final Function() onDelete;

  const ItemTodo({
    required this.todo,
    required this.onCheck,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[300],
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        leading: Checkbox(
          activeColor: Colors.green[800],
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
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onEdit,
              child: const Icon(Icons.edit_rounded),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: onDelete,
              child: const Icon(Icons.delete_rounded, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}