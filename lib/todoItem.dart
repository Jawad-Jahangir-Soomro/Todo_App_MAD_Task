import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
    required this.removeTodo,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        color: Colors.white70,
      ),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        leading: Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.black,
          value: todo.completed,
          onChanged: (value) {
            onTodoChanged(todo);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.name, style: _getTextStyle(todo.completed)),
            if (todo.date != null || todo.time != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    if (todo.date != null)
                      Text(
                        todo.date!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    if (todo.date != null && todo.time != null)
                      const SizedBox(width: 8),
                    if (todo.time != null)
                      Text(
                        todo.time!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
        trailing: IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.delete,
            color: Colors.black,
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            removeTodo(todo);
          },
        ),
      ),
    );
  }
}
