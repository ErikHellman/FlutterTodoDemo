import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_model.dart';

class TodoDetails extends StatefulWidget {
  final TodoItem todoItem;

  const TodoDetails(this.todoItem, {Key key}) : super(key: key);

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
    final deleteCallback = widget.todoItem.id != null
        ? () => _deleteItem(widget.todoItem)
        : null;
    return Scaffold(
      appBar: AppBar(title: Text('Item details')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(4)
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(4)
                  )
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 4, 0),
                child: RaisedButton.icon(
                    onPressed: () {
                      _saveItem(widget.todoItem);
                    },
                    icon: Icon(Icons.save),
                    label: Text('Save')),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
                child: RaisedButton.icon(
                    onPressed: deleteCallback,
                    icon: Icon(Icons.delete),
                    label: Text('Delete')),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveItem(TodoItem todoItem) async {
    final todoModel = Provider.of<TodoModel>(context, listen: false);

    todoItem.title = _titleController.text;
    todoItem.description = _descriptionController.text;
    await todoModel.save(todoItem);
    return Navigator.of(context).pop();
  }

  Future<void> _deleteItem(TodoItem todoItem) async {
    final todoModel = Provider.of<TodoModel>(context, listen: false);
    await todoModel.remove(todoItem);
    return Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
