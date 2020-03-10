import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_model.dart';

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
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
    Navigator.pushNamed(context, '/details',
        arguments: TodoItem(null, null, false));
  }
}

class TodoListItem extends StatefulWidget {
  final TodoItem item;

  TodoListItem(this.item);

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            print('Tap on ${widget.item}');
            Navigator.pushNamed(context, '/details', arguments: widget.item);
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.item.title,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      widget.item.description,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Checkbox(
                  value: widget.item.done,
                  onChanged: (value) {
                    widget.item.done = value;
                    Provider.of<TodoModel>(context, listen: false)
                        .addOrUpdate(widget.item);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
