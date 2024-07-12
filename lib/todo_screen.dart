import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_rosa/provider.dart';

class TodoList1 extends StatefulWidget {
  const TodoList1({super.key});

  @override
  State<TodoList1> createState() => _TodoList1State();
}

class _TodoList1State extends State<TodoList1> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () async {
                await todoProvider.getTodo();
              },
              child: Text("Ambil Data")),
          todoProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: todoProvider.dataTodo.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todoProvider.dataTodo[index].id ?? "-"),
                      subtitle: Text(todoProvider.dataTodo[index].title ?? "-"),
                      trailing:
                          Text(todoProvider.dataTodo[index].userId.toString()),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
