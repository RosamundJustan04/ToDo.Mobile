import 'package:flutter/material.dart';
import 'package:uts_rosa/model.dart';

class DetailedView extends StatelessWidget {
  final TodoModel todo;
  DetailedView({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Detail'),
        backgroundColor: Color.fromARGB(255, 246, 214, 214),
        foregroundColor: Color.fromARGB(255, 167, 168, 170),
      ),
      backgroundColor: Color.fromARGB(255, 244, 232, 225),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 226, 243), 
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    todo.title ?? "-",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 226, 243), 
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    todo.description ?? "-",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 226, 243), 
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Date/Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Start: ${todo.timeStart ?? "-"}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'End: ${todo.timeEnd ?? "-"}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
