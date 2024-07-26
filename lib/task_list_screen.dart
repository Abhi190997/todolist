import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/task_detail_screen.dart';
import 'package:todolist/task_provider.dart';


class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // Filter checked tasks
              List<String> checkedTasks = taskList.tasks.where((task) => task.isCompleted).map((task) => task.title).toList();

              // Navigate to TaskDetailsScreen with checkedTasks list
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailsScreen(checkedTasks: checkedTasks),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 16.0), // Adjust margin as needed
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: taskList.tasks.isEmpty
          ? const Center(
        child: Text(
          'No tasks added.',
          style: TextStyle(fontSize: 20.0),
        ),
      )
          : Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: taskList.tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(taskList.tasks[index].title),
                  value: taskList.tasks[index].isCompleted,
                  onChanged: (bool? isChecked) {
                    taskList.toggleTaskCompletion(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a New Task'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter task name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                String taskTitle = _controller.text.trim();
                if (taskTitle.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(taskTitle);
                  _controller.clear();
                  Navigator.of(context).pop();
                } else {
                  // Show an error message or handle empty task title
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a task name'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
