import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/task_list_screen.dart';
import 'package:todolist/task_provider.dart';

void main() {
  runApp(MyApp());
}
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do List App',
        home: TaskListScreen(),
      ),
    );
  }
}


