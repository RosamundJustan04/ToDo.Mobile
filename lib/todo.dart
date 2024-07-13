import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_rosa/provider.dart';
import 'package:uts_rosa/todolist.dart';

List<Map<String, dynamic>> todolist = [];

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TextEditingController todoNama = TextEditingController();
  TextEditingController todoKegiatan = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  void initState() {
    todoKegiatan.text = 0.toString();
    todoNama.text = 0.toString();
    super.initState();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (pickedStartDate != null && pickedStartDate != startDate) {
      setState(() {
        startDate = pickedStartDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedEndDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (pickedEndDate != null && pickedEndDate != endDate) {
      setState(() {
        endDate = pickedEndDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TodoProvider>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 246, 214, 214),
          foregroundColor: Color.fromARGB(255, 132, 133, 135),
          title: Text('TO-DO'),
          actions: [
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoList(todolist: todolist),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 244, 232, 225), 
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.list_alt),
                Padding(padding: EdgeInsetsDirectional.only(end: 5.0)),
                const Text('Kegiatan',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                    child: Padding(
                  padding: EdgeInsetsDirectional.all(10),
                  child: TextField(
                    controller: todoNama,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Anything!',
                    ),
                  ),
                ))
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.abc_outlined),
                Padding(padding: EdgeInsetsDirectional.only(end: 5.0)),
                Text('Keterangan',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoKegiatan,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tambah Keterangan',
                      ),
                      maxLines: 3,
                    ),
                  )
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        _selectStartDate(context);
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: startDate == null
                                ? 'Pilih Tanggal Mulai'
                                : startDate.toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        _selectEndDate(context);
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: endDate == null
                                ? 'Pilih Tanggal Selesai'
                                : endDate.toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: ElevatedButton(onPressed: () {}, child: Text('Batal')),
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: ElevatedButton(
                        onPressed: () async {
                          bool res = await prov.createTodo(
                            userId: 1,
                            title: todoNama.text,
                            description: todoKegiatan.text,
                            timeStart: startDate.toString(),
                            timeEnd: endDate.toString()
                          );

                          if(res) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoList(todolist: todolist),
                              ),
                            );
                          } else {
                            print('err');
                          }
                        },
                        child: Text('Simpan')),
                  ))
                ]),
          ],
        ));
  }
}
