import 'package:flutter/material.dart';
import 'package:todo_app/screens/second_screen.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todoItem.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});

  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> _todos = <Todo>[];
  final TextEditingController _textFieldController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(
        name: name,
        completed: false,
        date: _selectedDate?.toLocal().toString().split(' ')[0],
        time: _selectedTime?.format(context),
      ));
    });
    _textFieldController.clear();
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((element) => element.name == todo.name);
    });
  }

  void _deleteAll() {
    setState(() {
      _todos.clear();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _displayDialog() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Add task Clicked!"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(label: "Click Here", onPressed: () {}),
      ),
    );
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add your Tasks'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: 'Type your todo/task\'s'),
                  autofocus: true,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select Date'),
                    ),
                    if (_selectedDate != null)
                      Text(_selectedDate!.toLocal().toString().split(' ')[0]),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _selectTime(context),
                      child: const Text('Select Time'),
                    ),
                    if (_selectedTime != null)
                      Text(_selectedTime!.format(context)),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
              todo: todo,
              onTodoChanged: _handleTodoChange,
              removeTodo: _deleteTodo);
        }).toList(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SecondScreen(data: "View"),
                ),
              );
            },
            child: const Text(
              "Second Screen",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            onPressed: () => _deleteAll(),
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.delete,
              color: Colors.white70,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            onPressed: () => _displayDialog(),
            tooltip: 'Add your tasks/todo\'s',
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.add,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
