import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo_details_widget.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem item;

  TodoListItem(this.item);

  @override
  Widget build(BuildContext context) {
    final todoModel = Provider.of<TodoModel>(context);
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return TodoDetails(todoItem: item);
              }
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item?.title ?? '',
                        style: textTheme.headline6,
                      ),
                      Text(
                        item?.description ?? '',
                        style: textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                Checkbox(
                    value: item?.done ?? false,
                    onChanged: (value) {
                      item.done = value ;
                      todoModel.addOrUpdate(item);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
