import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/todo_model.dart';
import 'abstract/local_abstract.dart';

class TodoLocalDataSourceImplementation implements TodoLocalDataSource {
  TodoLocalDataSourceImplementation();

  static const String _tableName = 'todos';
  static const String _dbName = 'todo_app.db';
  static const int _dbVersion = 1;

  Database? _database;

  // Initialize database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) {
        // Create table with the 'completed' column
        return db.execute('''
        CREATE TABLE $_tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          todo TEXT NOT NULL,
          completed INTEGER NOT NULL DEFAULT 0,  -- Add completed column
          userId INTEGER
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Add the 'completed' column if it doesn't exist in the older version
          await db.execute(
              'ALTER TABLE $_tableName ADD COLUMN completed INTEGER NOT NULL DEFAULT 0');
        }
      },
    );
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final db = await database;
    await db.insert(
      _tableName,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final db = await database;
    await db.update(
      _tableName,
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<List<TodoModel>> getTodosByPaginate({
    required int pageNumber,
    required int limit,
  }) async {
    final db = await database;
    final offset = (pageNumber - 1) * limit;

    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      limit: limit,
      offset: offset,
    );

    return result.map((json) => TodoModel.fromJson(json)).toList();
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    final db = await database;

    // Clear existing data
    await db.delete(_tableName);

    // Insert new data
    for (var todo in todos) {
      await db.insert(
        _tableName,
        todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
