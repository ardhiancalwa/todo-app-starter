import 'package:flutter/material.dart';
import 'package:to_do_app/widget/item_todo.dart';

import '../data/hive_database.dart';
import '../widget/empty_data.dart';
import '../widget/item_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final hiveDatabase = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('To Do App'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: hiveDatabase.getTodos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final totalData = snapshot.data!.length;
              final totalActive = snapshot.data!
                  .map((todo) => todo.isDone)
                  .where((element) => element == false)
                  .toList()
                  .length;
              return snapshot.data!.isEmpty
                  ? const EmptyData()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '$totalActive active tasks out of $totalData',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final todos = snapshot.data!;
                              return ItemTodo(
                                todo: todos[index],
                                onCheck: (value) async {
                                  await hiveDatabase.updateStatus(
                                    index,
                                    todos[index],
                                  );
                                  setState(() {});
                                },
                                onEdit: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/add',
                                    arguments: index,
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                onDelete: () async {
                                  await hiveDatabase.deleteTodo(index);
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        onPressed: () => Navigator.pushNamed(context, '/add').then((_) {
          setState(() {});
        }),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
