import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_details_widget.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem item;

  TodoListItem(this.item) : super(key: ValueKey(item.id));

  @override
  Widget build(BuildContext context) {
    final todoModel = Provider.of<TodoModel>(context);
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return TodoDetails(todoItem: item);
          }));
        },
        child: Text(
          item?.title ?? '',
          style: textTheme.headline6,
        ),
      ),
    );
  }
}
