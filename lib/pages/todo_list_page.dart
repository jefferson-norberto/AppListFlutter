import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ToDoListPage extends StatefulWidget {
  ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository repository = TodoRepository();
  List<Todo> todos = [];
  Todo? todoDeleted;
  int? todoDeletedPosition;
  String? erroText;

  @override
  void initState() {
    super.initState();

    repository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

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
                        onSubmitted: onSubmitted,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.teal),
                          border: const OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          hintText: "Ex. Estudar Flutter",
                          errorText: erroText,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                              width: 2,
                            )
                          )
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: addTodo,
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(todo: todo, onDelete: onDelete),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("Voc?? tem ${todos.length} tarefas"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: showDeleteConfirmationDialog,
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

  void addTodo() {
    String text = todoController.text;
    if(text.isEmpty){
      setState(() {
        erroText = "O titulo n??o pode ser vazio";
      });
    }else{
      setState(() {
        Todo newTodo = Todo(title: text, date: DateTime.now());
        todos.add(newTodo);
        erroText = null;
      });
      todoController.clear();
      repository.saveTodoList(todos);
    }
  }

  // S?? e chamada quando aperto enter no teclado
  void onSubmitted(String text) {
    addTodo();
  }

  void showScreenLoading(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Aguarde..."),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.threeArchedCircle(
                color: Colors.teal,
                size: 100,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){Navigator.of(context).pop();},
              child: const Text("OK"),
              style: TextButton.styleFrom(primary: Colors.teal),
            ),
          ],
        ));
  }

  void showDeleteConfirmationDialog(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Limpar tudo?"),
          content: const Text("Voc?? tem certeza que deseja apagar tudo?"),
          actions: [
            TextButton(
              onPressed: (){Navigator.of(context).pop();},
              child: const Text("Cancelar"),
              style: TextButton.styleFrom(primary: Colors.teal),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                deleteAllTodos();
              },
              child: const Text("Limpar Tudo",),
              style: TextButton.styleFrom(primary: Colors.red),
            ),
          ],
    ));
    repository.saveTodoList(todos);
  }

  void deleteAllTodos(){
    showScreenLoading();
    setState(() {
      todos.clear();
    });
    repository.saveTodoList(todos);
  }

  void onDelete(Todo todo) {
    todoDeleted = todo;
    todoDeletedPosition = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
      repository.saveTodoList(todos);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} foi removida!",
          style: const TextStyle(color: Colors.teal),
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.red,
          onPressed: () {
            setState(() {
              todos.insert(todoDeletedPosition!, todoDeleted!);
              repository.saveTodoList(todos);
            });
          },
        ),
      ),
    );
  }
}
