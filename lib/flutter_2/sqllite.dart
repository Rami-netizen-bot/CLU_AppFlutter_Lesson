import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lesson_flutter/model/todo_model.dart';

// Storage Helper
class TodoStorage {
  static const String _key = 'todo_list';

  Future<List<Todo>> getTodos() async {
    // Preparing the Storage Connection
    // This line opens a connection to the device's persistent storage. Because reading from the disk takes time, this operation is asynchronous (await).
    final prefs = await SharedPreferences.getInstance();
    // Fetching the Data
    // SharedPreferences stores data as key-value pairs where the value must be a simple type (like a String). You are retrieving the entire list of Todos as a single, long JSON-formatted String.
    final String? jsonString = prefs.getString(_key);
    // Print
    debugPrint('DEBUG: Loaded JSON from SharedPreferences: $jsonString');
    // Handling First-Run Scenarios
    // If the app has never saved a Todo before, jsonString will be null. This line prevents errors by returning an empty List if there is no data to load.
    if (jsonString == null) return [];
    // Decoding
    //The jsonDecode function takes that raw string and parses it into a Dart structure, which results in a List<dynamic>. At this stage, your data is still just "raw" maps (dictionaries) of data—it doesn't have the methods or properties of a Todo class yet.
    final List<dynamic> decoded = jsonDecode(jsonString);
    // transforming to Objects
    // This is the final step. It iterates through the list of maps and calls Todo.fromMap(item) for every entry. This converts each raw map into a proper Todo class instance, allowing you to use your object properties (like .title or .isDone) throughout your app.
    return decoded.map((item) => Todo.fromMap(item)).toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    // This initializes the storage interface so you can write data to the device.
    final prefs = await SharedPreferences.getInstance();
    // SharedPreferences doesn't know what a Todo object is. By calling .toMap(), you convert each Todo instance into a standard Map<String, dynamic> (e.g., {'title': 'Homework', 'isDone': 0}).
    final String jsonString = jsonEncode(todos.map((t) => t.toMap()).toList());
    // Print method
    debugPrint('DEBUG: Saving JSON to SharedPreferences: $jsonString');
    await prefs.setString(_key, jsonString);
  }
}

class SharedPrefsDemo extends StatefulWidget {
  const SharedPrefsDemo({super.key});

  @override
  State<SharedPrefsDemo> createState() => _SharedPrefsDemoState();
}

class _SharedPrefsDemoState extends State<SharedPrefsDemo> {
  List<Todo> _todos = [];
  final TodoStorage _storage = TodoStorage();

  @override
  void initState() {
    super.initState();
    _refreshTodos();
  }

  Future<void> _refreshTodos() async {
    // Asynchronous Data Retrieval
    final todos = await _storage.getTodos();
    setState(() => _todos = todos);
  }

  // Implementation of Insert, Update, Delete
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
              final text = controller.text.trim();
              if (text.isEmpty) return;

              if (isEditing) {
                // UPDATE Logic
                final index = _todos.indexWhere((t) => t.id == todo!.id);
                _todos[index].title = text;
              } else {
                // INSERT Logic
                _todos.add(
                  Todo(
                    id: DateTime.now()
                        .millisecondsSinceEpoch, // Generate simple unique ID
                    title: text,
                  ),
                );
              }

              await _storage.saveTodos(_todos);
              Navigator.pop(context);
              _refreshTodos();
            },
            child: Text(isEditing ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteTodo(int id) async {
    // DELETE Logic
    _todos.removeWhere((todo) => todo.id == id);
    await _storage.saveTodos(_todos);
    _refreshTodos();
  }

  Future<void> _toggleTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    _todos[index].isDone = !_todos[index].isDone;
    await _storage.saveTodos(_todos);
    _refreshTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SharedPreferences Todo')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return Dismissible(
            key: ValueKey(todo.id),
            onDismissed: (_) => _deleteTodo(todo.id!),
            child: ListTile(
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (_) => _toggleTodo(todo),
              ),
              title: Text(todo.title),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _addOrEditTodo(todo: todo),
              ),
            ),
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
