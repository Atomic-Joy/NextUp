// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/nextup.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NextUp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> _todos = [];
  final _textController = TextEditingController();

  void _addTodo(String title) {
    setState(() {
      _todos.add(Todo(
        id: DateTime.now().toString(),
        title: title,
        completed: false,
      ));
    });
    _textController.clear();
  }

  void _toggleTodo(String id) {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.completed = !todo.completed;
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),  // Beige background for the entire app
      appBar: AppBar(
        title: Center(
          child: Text(
            'NextUp',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,  // Bold title
              fontStyle: FontStyle.italic,  // Apply Italics
            ),
          ),
        ),
        backgroundColor: Color(0xFF9E7B4F),  // Light Brown color for the AppBar
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: GoogleFonts.lora(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter a new task...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Color(0xFF9E7B4F)),  // Light Brown border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Color(0xFF9E7B4F), width: 2),  // Light Brown focused border
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  FloatingActionButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        _addTodo(_textController.text);
                      }
                    },
                    backgroundColor: Color(0xFF9E7B4F),  // Light Brown for the FAB
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Dismissible(
                        key: Key(todo.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => _deleteTodo(todo.id),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.red,
                          child: Icon(Icons.delete, color: Colors.white, size: 32),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: GestureDetector(
                            onTap: () => _toggleTodo(todo.id),
                            child: CircleAvatar(
                              backgroundColor: todo.completed ? Colors.green : Colors.red,
                              child: Icon(
                                todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          title: Text(
                            todo.title,
                            style: GoogleFonts.lora(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              decoration: todo.completed ? TextDecoration.lineThrough : null,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Color(0xFF9E7B4F)),  // Light Brown delete icon
                            onPressed: () => _deleteTodo(todo.id),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
