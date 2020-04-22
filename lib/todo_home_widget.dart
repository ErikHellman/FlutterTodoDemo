import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_details_widget.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_list_item_widget.dart';
import 'package:todo_app/todo_model.dart';

class TodoHome extends StatefulWidget {
  @override
  _TodoHomeState createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  TodoModel _todoModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _todoModel = Provider.of<TodoModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Items'),
      ),
      body: Center(
        child: Container(
          child: ListView(
            children:
                _todoModel.items.map((item) => TodoListItem(item)).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addItem() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TodoDetails(todoItem: TodoItem(created: DateTime.now()));
    }));
  }
}
