import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/todo_item.dart';

class TodoModel with ChangeNotifier {
  static const VERSION = 5;
  List<TodoItem> _items = [];

  List<TodoItem> get items {
    if (database == null) _openDatabase();
    return List.unmodifiable(_items);
  }

  Database database;

  Future<void> _openDatabase() async {
    database = await openDatabase('todo.db', version: VERSION,
        onCreate: (db, version) async {
      db.execute(
          "CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, description TEXT, created INTEGER)");
    },
        onUpgrade: (db, oldVersion, newVersion) async {
          db.execute('DROP TABLE IF EXISTS todo');
          db.execute(
              "CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, description TEXT, created INTEGER)");
        },
        onOpen: (db) async {
      final resultSet = await db.query('todo', orderBy: 'created');
      _items = resultSet.map((row) => TodoItem.fromMap(row)).toList();
      notifyListeners();
    });
  }

  Future<void> _loadItems() async {
    final resultSet = await database.query('todo', orderBy: 'created');
    _items = resultSet.map((row) => TodoItem.fromMap(row)).toList();
    notifyListeners();
  }

  Future<void> addOrUpdate(TodoItem item) async {
    print('addOrUpdate: $item');
    if (database == null) await _openDatabase();
    await database.insert('todo', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await _loadItems();
  }

  Future<void> remove(TodoItem item) async {
    if (database == null) await _openDatabase();
    await database.delete('todo', where: 'id = ?', whereArgs: [item.id]);
    await _loadItems();
  }

  @override
  void dispose() {
    super.dispose();
    database.close();
  }
}
