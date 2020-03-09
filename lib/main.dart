import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  TodoHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addItem,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _addItem() {
  }
}
