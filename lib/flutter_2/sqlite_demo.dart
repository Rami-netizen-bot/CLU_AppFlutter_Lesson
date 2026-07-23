import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Todo model
class Todo {
  int? id;
  String title;
  bool isDone;

  Todo({
    this.id,
    required this.title,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'] == 1,
    );
  }
}

// SQLite helper
class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            isDone INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Todo>> getTodos() async {
    final db = await instance.database;
    final result = await db.query('todos', orderBy: 'id DESC');
    return result.map((json) => Todo.fromMap(json)).toList();
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toMap());
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }
}

class SqliteDemo extends StatefulWidget {
  const SqliteDemo({super.key});

  @override
  State<SqliteDemo> createState() => _SqliteDemoState();
}

class _SqliteDemoState extends State<SqliteDemo> {
  List<Todo> _todos = [];
  bool _isLoading = true;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _refreshTodos();
  }

  Future<void> _refreshTodos() async {
    setState(() => _isLoading = true);
    final todos = await TodoDatabase.instance.getTodos();
    if (mounted) {
      setState(() {
        _todos = todos;
        // Delay 2 second
        // Then _isLoading = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _addOrEditTodo({Todo? todo}) async {
    final controller = TextEditingController(text: todo?.title ?? '');
    final isEditing = todo != null;

    await showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Todo' : 'Add Todo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter todo title'),
        ),
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
                await TodoDatabase.instance.updateTodo(
                  Todo(id: todo!.id, title: text, isDone: todo.isDone),
                );
              } else {
                await TodoDatabase.instance.insertTodo(
                  Todo(title: text),
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

  Future<void> _deleteTodo(int id) async {
    await TodoDatabase.instance.deleteTodo(id);
    _refreshTodos();
  }

  Future<void> _toggleTodo(Todo todo) async {
    await TodoDatabase.instance.updateTodo(
      Todo(
        id: todo.id,
        title: todo.title,
        isDone: !todo.isDone,
      ),
    );
    _refreshTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Todo App'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _todos.isEmpty
              ? const Center(child: Text('No todos yet.'))
              : ListView.builder(
                  itemCount: _todos.length,
                  itemBuilder: (context, index) {
                    final todo = _todos[index];
                    return Dismissible(
                      key: ValueKey(todo.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (_) => _deleteTodo(todo.id!),
                      child: ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (_) => _toggleTodo(todo),
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone ? TextDecoration.lineThrough : null,
                          ),
                        ),
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

  @override
  void dispose() {
    _disposed = true;
    TodoDatabase.instance.close();
    super.dispose();
  }
}
