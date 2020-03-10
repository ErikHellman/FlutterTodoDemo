import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_model.dart';

class TodoDetails extends StatefulWidget {
  @override
  _TodoDetailsState createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  TodoItem _item;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _item = ModalRoute.of(context).settings.arguments;
    _titleController.text = _item.title;
    _descController.text = _item.description;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Change item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              maxLines: 1,
              keyboardType: TextInputType.text,
              autocorrect: true,
              enableSuggestions: true,
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description', alignLabelWithHint: true),
              keyboardType: TextInputType.multiline,
              autocorrect: true,
              enableSuggestions: true,
              maxLines: 10,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _item.title = _titleController.value.text;
          _item.description = _descController.value.text;
          Provider.of<TodoModel>(context, listen: false).addOrUpdate(_item);
          Navigator.pop(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }
}
