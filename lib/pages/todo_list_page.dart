import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class ToDoListPage extends StatefulWidget {
  ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  int task = 0;

  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          hintText: "Ex. Estudar Flutter",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: addTodo,
                      child: const Icon(Icons.add, size: 30,),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for(Todo todo in todos)
                        TodoListItem(todo: todo,),
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                      child: Text("Você tem $task tarefas"),
                    ),
                    const SizedBox(width: 8,),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Limpar tudo"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        padding: const EdgeInsets.all(18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }

  void addTodo(){
    String text = todoController.text;
    setState(() {
      Todo newTodo = Todo(
        title: text,
        date: DateTime.now()
      );
      todos.add(newTodo);
      task = todos.length;
    });
    todoController.clear();
  }
}
