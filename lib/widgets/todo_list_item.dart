import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo, required this.onDelete}) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
    child: Slidable(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              todo.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              DateFormat('dd/MM/yyyy - HH:mm:ss').format(todo.date),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
        actionExtentRatio: 0.25,
        actionPane: const SlidableDrawerActionPane(),
      actions: [
        IconSlideAction(
          color: Colors.teal,
          icon: Icons.edit,
          caption: "Editar",
          onTap: () {},
        ),
      ],
      secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: "Deletar",
            onTap: () { onDelete(todo); },
          ),
        ],
      ),
    );
  }
}
