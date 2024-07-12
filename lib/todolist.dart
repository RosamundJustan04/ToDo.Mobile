import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uts_rosa/model.dart';
import 'package:uts_rosa/provider.dart';
// import 'package:praktek_m04/latihan1/todo.dart';
// import 'package:flutter/widgets.dart';

class TodoList extends StatefulWidget {
  final List<Map<String, dynamic>> todolist;
  TodoList({Key? key, required this.todolist}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    Future.microtask(() async {
      await context.read<TodoProvider>().getTodo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final prov = context.watch<TodoProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('TO-DO LIST'),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.blueAccent,
      ),
      body: prov.isLoading ? Center(child: CircularProgressIndicator(),) :      
      ListView.builder(
        itemCount: prov.dataTodo.length,
        itemBuilder: (context, index) {
          List<TodoModel> data = prov.dataTodo;

          String todoNama = data[index].title ?? "-";
          String todoKegiatan = data[index].description ?? "-";
          String todoTanggalMulai = data[index].timeStart ?? "-";
          String todoTanggalAkhir = data[index].timeEnd ?? "-";

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      SizedBox(
                          width: 16), // Add spacing between CircleAvatar and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todoNama,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("$todoKegiatan"),
                        ],
                      ),
                    ],
                  ),
               
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "$todoTanggalMulai (Tanggal Mulai)"),
                        Text("$todoTanggalAkhir (Tanggal Selesai)"),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(), // Add a divider between each todo item
            ],
          );
        },
      ),
    );
  }
}
