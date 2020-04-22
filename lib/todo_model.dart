import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/todo_item.dart';

class TodoModel with ChangeNotifier {
  List<TodoItem> _items = [];

  List<TodoItem> get items {
    if (database == null) _openDatabase();
    return List.unmodifiable(_items);
  }
  Database database;

  Future<void> _openDatabase() async {
    database = await openDatabase('my_db.db', version: 1,
        onCreate: (db, version) async {
      db.execute(
          "CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, description TEXT, created INTEGER, done INTEGER)");
    }, onOpen: (db) async {
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
    database.close();
  }
}
