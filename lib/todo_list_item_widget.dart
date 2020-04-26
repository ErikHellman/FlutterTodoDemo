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
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        child: InkWell(
          onTap: () => _openDetails(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item?.title ?? '',
              style: textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }

  Future _openDetails(BuildContext context) {
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => TodoDetails(item)
      ));
  }
}
