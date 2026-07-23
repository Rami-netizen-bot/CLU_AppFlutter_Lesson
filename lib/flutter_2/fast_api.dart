import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lesson_flutter/model/todo_model.dart';

// 1. Todo Model

// 2. API Service (Replacing TodoStorage)
class ApiService {
  final String baseUrl = "http://10.0.2.2:8000"; // For Android Emulator

  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));
    debugPrint('API Response: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Todo.fromMap(item)).toList();
    }
    return [];
  }

  Future<void> addTodo(Todo todo) async {
    await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toMap()),
    );
  }

  Future<void> updateTodo(Todo todo) async {
    await http.put(
      Uri.parse('$baseUrl/todos/${todo.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toMap()),
    );
  }

  Future<void> deleteTodo(int id) async {
    await http.delete(Uri.parse('$baseUrl/todos/$id'));
  }
}

// 3. UI
class ApiTodoScreen extends StatefulWidget {
  const ApiTodoScreen({super.key});

  @override
  State<ApiTodoScreen> createState() => _ApiTodoScreenState();
}

class _ApiTodoScreenState extends State<ApiTodoScreen> {
  List<Todo> _todos = [];
  final ApiService _api = ApiService();

  @override
  void initState() {
    super.initState();
    _refreshTodos();
  }

  Future<void> _refreshTodos() async {
    final todos = await _api.getTodos();
    setState(() => _todos = todos);
  }

  Future<void> _addOrEditTodo({Todo? todo}) async {
    final controller = TextEditingController(text: todo?.title ?? '');
    final isEditing = todo != null;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Todo' : 'Add Todo'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isEmpty) return;

              if (isEditing) {
                todo!.title = controller.text;
                await _api.updateTodo(todo);
              } else {
                await _api.addTodo(
                  Todo(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: controller.text,
                  ),
                );
              }
              Navigator.pop(context);
              _refreshTodos();
            },
            child: Text(isEditing ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Todo App')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await _api.deleteTodo(todo.id);
                _refreshTodos();
              },
            ),
            onTap: () => _addOrEditTodo(todo: todo),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditTodo(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
