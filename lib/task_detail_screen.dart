import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  final List<String> checkedTasks;

  TaskDetailsScreen({required this.checkedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Completed Tasks'),
      ),
      body: ListView.builder(
        itemCount: checkedTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(checkedTasks[index]),
          );
        },
      ),
    );
  }
}