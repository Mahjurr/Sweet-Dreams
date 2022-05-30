import 'package:cloud_firestore/cloud_firestore.dart';
import 'todo.dart';
import 'utils.dart';


class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection("todo").doc();
    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }
  static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection("todo")
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
  //  .map((snapshot) => snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList());
      .transform(Utils.transformer(Todo.fromJson));

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection("todo").doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection("todo").doc(todo.id);

    await docTodo.delete();
  }
}