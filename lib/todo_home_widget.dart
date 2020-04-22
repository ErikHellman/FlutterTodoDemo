import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_item.dart';
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
        title: Text('TODO App'),
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: _todoModel.items
                .sortAndReturn((a, b) => a.compare(b))
                .map((item) => TodoListItem(item))
                .toList(),
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

//  Typing something!
  void _addItem() {}
}

class TodoListItem extends StatelessWidget {
  final TodoItem item;

  TodoListItem(this.item);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                      item.title,
                      style: textTheme.headline6,
                    ),
                    Text(
                      item.description,
                      style: textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              Checkbox(
                  value: item.done,
                  onChanged: (value) {
                    item.done = value;
                    Provider.of<TodoModel>(context, listen: false)
                        .addOrUpdate(item);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

extension SortExtension<T> on List<T> {
  List<T> sortAndReturn(int Function(T a, T b) compare) {
    var sortedList = List<T>.from(this).toList();
    sortedList.sort(compare);
    return List.unmodifiable(sortedList);
  }
}
