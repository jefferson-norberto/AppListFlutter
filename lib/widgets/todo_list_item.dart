import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:intl/intl.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
