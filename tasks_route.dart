import 'package:flutter/material.dart';
import './route_layout.dart';

class TasksRoute extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<TasksRoute> {
  List<_Task> tasks = [
    _Task('Getting started'),
    _Task('Check a todo'),
  ];
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Text('hello');
    return RouteLayout(
      title: 'Tasks',
      child: ListView.builder(
        padding: EdgeInsets.all(20.0),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          var task = tasks[index];
          return Row(
            children: <Widget>[
              Checkbox(
                value: task.done,
                onChanged: (bool newValue) {
                  setState(() {
                    task.done = newValue;
                  });
                }
              ),
              Text(task.text),
            ],
          );
        },
      ),
      action: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add new todo',
        onPressed: () {
          setState(() {
            tasks.add(_Task('new one'));
          });
        },
      ),
    );
  }
}

class _Task {
  _Task(this.text);
  final String text;
  bool done = false;
}
