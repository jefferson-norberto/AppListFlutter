import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';
import 'dart:convert';

const todoListKey = 'todo_list';

class TodoRepository{

  late SharedPreferences repository;

  void saveTodoList(List<Todo> todos){
    final String jsonString = json.encode(todos);
    repository.setString(todoListKey, jsonString);
  }

  Future<List<Todo>> getTodoList() async{
    repository = await SharedPreferences.getInstance();
    final String jsonString = repository.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }
}