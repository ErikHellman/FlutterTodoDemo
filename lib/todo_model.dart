import 'package:flutter/material.dart';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:todo_app/todo_item.dart';

class TodoModel with ChangeNotifier {
  static const VERSION = 8;
  static const String _TODOS_DB = 'todo.db';
  static const String _TODOS_STORE = 'todos';

  List<TodoItem> _items = [];

  List<TodoItem> get items {
    if (database == null) _openDatabase();
    print('Got ${_items.length} items.');
    return List.unmodifiable(_items);
  }

  Database database;

  Future<void> save(TodoItem item) async {
    try {
      if (database == null) await _openDatabase();
      final txn = database.transaction(_TODOS_STORE, 'readwrite');
      final store = txn.objectStore(_TODOS_STORE);
      var key = await store.put(item.toMap(), item.id);
      print('Save result: $key');
      _loadItems(store);
    } catch (e) {
      print(e);
    }
  }

  Future<void> remove(TodoItem item) async {
    try {
      if (database == null) await _openDatabase();
      final txn = database.transaction(_TODOS_STORE, 'readwrite');
      final store = txn.objectStore(_TODOS_STORE);
      print('Delete ${item.id}');
      final result = await store.delete(item.id);
      print('Deleted: $result');
      _loadItems(store);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    database.close();
  }

  Future<void> _openDatabase() async {
    IdbFactory idbFactory = getIdbFactory();
    database = await idbFactory.open(_TODOS_DB, version: VERSION,
        onUpgradeNeeded: (event) async {
      print('onUpgradeNeeded!');
      try {
        Database db = event.database;
        if (!db.objectStoreNames.contains(_TODOS_STORE)) {
          print('Create TODO store!');
          ObjectStore store =
              db.createObjectStore(_TODOS_STORE, autoIncrement: true);
          print('Add default data!');
          var itemOne = TodoItem(
              title: 'Plan Flutter presentation!',
              description: 'Make it fun!',
              created: DateTime.now());
          ;
          print('Add: $itemOne');
          final keyOne = await store.put(itemOne.toMap());
          itemOne.id = keyOne;
          print('Stored: $itemOne');
          var itemTwo = TodoItem(
              title: 'Feed the cats',
              description: 'They will interrupt you presentation otherwise',
              created: DateTime.now());
          print('Add: $itemTwo');
          final keyTwo = await store.put(itemTwo.toMap());
          itemTwo.id = keyTwo;
          print('Stored: $itemTwo');
          var itemThree = TodoItem(
              title: 'Learn COBOL',
              description: 'It is the future!',
              created: DateTime.now());
          print('Add: $itemThree');
          final keyThree = await store.put(itemThree.toMap());
          itemThree.id = keyThree;
          print('Stored: $itemThree');
        }
      } catch (e) {
        print(e);
      }
    });
    final txn = database.transaction(_TODOS_STORE, 'readonly');
    final store = txn.objectStore(_TODOS_STORE);
    await _loadItems(store);
  }

  Future<void> _loadItems(ObjectStore store) async {
    try {
      var items = <TodoItem>[];
      var stream = store
              .openCursor(autoAdvance: true)
              .map((cursor) => TodoItem.fromMap(cursor.value, cursor.key));
      var subscription = stream.listen((item) => items.add(item));
      await subscription.asFuture();
      print('Done loading: $items');
      _items = items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
