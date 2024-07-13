import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_rosa/model.dart';
import 'package:uts_rosa/provider.dart';
import 'detailed_view.dart';

class TodoList extends StatefulWidget {
  final List<Map<String, dynamic>> todolist;
  TodoList({Key? key, required this.todolist}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Set<int> completedTodoIds = {};

  @override
  void initState() {
    Future.microtask(() async {
      await context.read<TodoProvider>().getTodo();
    });
    super.initState();
  }

  void toggleTodoCompletion(int todoId) {
    setState(() {
      if (completedTodoIds.contains(todoId)) {
        completedTodoIds.remove(todoId);
      } else {
        completedTodoIds.add(todoId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TodoProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('TO-DO LIST'),
        backgroundColor: Color.fromARGB(255, 246, 214, 214),
          foregroundColor: Color.fromARGB(255, 132, 133, 135),
      ),
      backgroundColor: Color.fromARGB(255, 244, 232, 225), 
      body: prov.isLoading ? Center(child: CircularProgressIndicator(),) :      
      ListView.builder(
        itemCount: prov.dataTodo.length,
        itemBuilder: (context, index) {
          List<TodoModel> data = prov.dataTodo;

          String todoNama = data[index].title ?? "-";
          String todoKegiatan = data[index].description ?? "-";
          String todoTanggalMulai = data[index].timeStart ?? "-";
          String todoTanggalAkhir = data[index].timeEnd ?? "-";
          bool isCompleted = data[index].id != null && completedTodoIds.contains(data[index].id);

          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedView(todo: data[index]),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        SizedBox(width: 16), // Add spacing between CircleAvatar and text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todoNama,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            ),
                            Text(
                              "$todoKegiatan",
                              style: TextStyle(
                                decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("$todoTanggalMulai (Tanggal Mulai)"),
                          Text("$todoTanggalAkhir (Tanggal Selesai)"),
                        ],
                      ),
                    ),
                    Checkbox(
                      value: isCompleted,
                      onChanged: (bool? value) {
                        if (value != null && data[index].id != null) {
                          toggleTodoCompletion(data[index].id! as int);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Divider(), // Add a divider between each todo item
            ],
          );
        },
      ),
    );
  }
}
