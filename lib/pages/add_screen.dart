import 'package:flutter/material.dart';
import 'package:to_do_app/widget/todo_textfield.dart';

import '../data/hive_database.dart';
import '../model/todo.dart';
import '../widgets/todo_textfiled.dart';

class AddScreen extends StatefulWidget {
  final int? index;
  const AddScreen({this.index, super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final hiveDatabase = HiveDatabase();
  Todo? _todo;

  Future<Todo?> loadTodo() async {
    if (widget.index != null) {
      _todo = await hiveDatabase.getTodoByIndex(widget.index!);
    }
    return _todo;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text(widget.index != null ? 'Edit' : 'Add'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: loadTodo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TodoTextField(
                      hint: 'Title',
                      controller: titleController
                        ..text = _todo != null ? _todo!.title : '',
                      inputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    TodoTextField(
                      hint: 'Description',
                      controller: descriptionController
                        ..text = _todo != null ? _todo!.description : '',
                      inputAction: TextInputAction.done,
                      maxLines: 10,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[300]),
                      ),
                      onPressed: () async {
                        if (widget.index != null) {
                          _todo = Todo(
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                          await hiveDatabase.updateTodo(widget.index!, _todo!);
                        } else {
                          final todo = Todo(
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                          await hiveDatabase.addTodo(todo);
                        }
                        if (context.mounted) Navigator.pop(context);
                      },
                      child: Text(
                        widget.index != null ? 'Edit' : 'Save',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
