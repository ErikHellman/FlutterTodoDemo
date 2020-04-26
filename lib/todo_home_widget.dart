import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_details_widget.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_list_item_widget.dart';
import 'package:todo_app/todo_model.dart';

class TodoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoModel = Provider.of<TodoModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Items'),
      ),
      body: ListView(
        children: todoModel.items.map((item) => TodoListItem(item)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Add new todo item!'),
        tooltip: 'Add todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
