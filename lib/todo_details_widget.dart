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
    bool isNew = widget.todoItem.id == null;
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
      body: Center(child: Text('Nothing here yet!'),),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveItem(todoModel),
        child: Icon(Icons.done),
      ),
    );
  }

  Future<void> _saveItem(TodoModel todoModel) {
    widget.todoItem.title = _titleController.text;
    widget.todoItem.description = _descriptionController.text;
    todoModel.save(widget.todoItem);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
