import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoListPage extends StatelessWidget {
  ToDoListPage({Key? key}) : super(key: key);

  int task = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
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
                    onPressed: () {},
                    child: const Icon(Icons.add, size: 30,),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      padding: const EdgeInsets.all(18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.blueGrey,
                      child: Text("Exemplo"),
                    ),
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
    );
  }
}
