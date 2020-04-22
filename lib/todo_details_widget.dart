import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_model.dart';

class TodoDetails extends StatefulWidget {
  final TodoItem todoItem;

  const TodoDetails({Key key, this.todoItem}) : super(key: key);

  @override
  _TodoDetailsState createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.todoItem?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.todoItem?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.todoItem.id == 0;
    final todoModel = Provider.of<TodoModel>(context);
    var deleteButton = !isNew ? FlatButton(
              onPressed: () async {
                await todoModel.remove(widget.todoItem);
                Navigator.of(context).pop();
              },
              child: Text('Delete'))
        : null;
    return Scaffold(
      appBar: AppBar(title: Text('Item details')),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
          ),
          TextField(
            controller: _descriptionController,
          ),
          deleteButton ?? Spacer()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.todoItem.title = _titleController.text;
          widget.todoItem.description = _descriptionController.text;
          todoModel.addOrUpdate(widget.todoItem);
          Navigator.of(context).pop();
        },
        child: Icon(Icons.done),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
