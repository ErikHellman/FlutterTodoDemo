import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_home_page.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_item_widget.dart';
import 'package:todo_app/todo_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var todoModel = TodoModel();
    return MultiProvider(
      providers: [ChangeNotifierProvider<TodoModel>(create: (_) => todoModel)],
      child: MaterialApp(
        title: 'TODO Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => TodoHomePage(),
          '/details': (context) => TodoDetails(),
        },
      ),
    );
  }
}
