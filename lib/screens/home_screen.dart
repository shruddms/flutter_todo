import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/screens/input_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    var savedTodos = prefs.getStringList('todos');
    if (savedTodos == null) return;

    setState(() {
      todos = savedTodos.map((e) => Todo.fromJson(jsonDecode(e))).toList();
    });
  }

  void saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'todos', todos.map((e) => jsonEncode(e.toJson())).toList());
  }

  void removeTodo(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
    saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: todos.isEmpty
          ? const Center(
        child: Text(
          'No tasks added yet',
          style: TextStyle(fontSize: 20),
        ),
      )
          : ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Dismissible(
            key: Key(todo.id),
            onDismissed: (direction) {
              removeTodo(todo);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.content),
              trailing: Checkbox(
                value: todo.done,
                onChanged: (value) {
                  setState(() {
                    todo.done = value!;
                  });
                  saveTodos();
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTodo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InputScreen()),
          );
          if (newTodo != null) {
            setState(() {
              todos.add(newTodo);
            });
            saveTodos();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
