import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uts_rosa/model.dart';

class TodoProvider extends ChangeNotifier {
  var db = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set _isloading(val) {
    _isLoading = val;
    notifyListeners();
  }

  List<TodoModel> _dataTodo = [];
  List<TodoModel> get dataTodo => _dataTodo;
  set setDataTodo(val) {
    _dataTodo.add(val);
    notifyListeners();
  }

  getTodo() async {
    try {
      _isLoading = true;
      await db.collection('todo').get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          setDataTodo = TodoModel.fromJson(element.data());
        });
      });
    } catch (e) {
      print('Error while fetching data: $e');
    } finally {
      _isLoading = false;
    }
  }

  Future<bool> createTodo({
    userId,
    title,
    description,
    timeStart,
    timeEnd,
  }) async {
    late bool results;
    final docRef = db.collection('todo').doc();

    TodoModel todolist = TodoModel(
      userId: userId,
      id: docRef.id,
      title: title,
      description: description,
      timeStart: timeStart,
      timeEnd: timeEnd,
    );

    await db.collection('todo').add(todolist.toJson()).then((val) {
      print('to do list done!');
      results = true;
    }, onError: (error) {
      print('Error while check: $error');
      results = false;
    });

    return results;
  }
}
