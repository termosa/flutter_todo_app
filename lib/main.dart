import 'package:flutter/material.dart';

const appTitle = 'YATODO';
const backgroundColor = Colors.white;
const textColor = Colors.black;

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TasksRoute();
  }
}

class TasksRoute extends StatefulWidget {
  @override
  TasksRouteState createState() => TasksRouteState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class TasksRouteState extends State<TasksRoute> {
  List<Task> tasks = [
    Task('Getting Started'),
    Task('Check a todo'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: backgroundColor,
          centerTitle: false,
          title: Text(
            'Title',
            style: TextStyle(
              color: textColor,
              fontSize: 30.0,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        body: ListView.builder(
          padding: EdgeInsets.all(20.0),
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            Task task = tasks[index];
            return Row(
              children: <Widget>[
                Checkbox(
                  value: task.done,
                  onChanged: (bool newValue) {
                    setState(() {
                      task.toggle();
                    });
                  }
                ),
                Text(task.text),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Add new todo',
          onPressed: () => _act(),
        ),
        bottomSheet: CreateForm(),
      ),
    );
  }

  _act() {
    print('acting');
    if (false) {
      scaffoldKey.currentState.showBottomSheet<Null>((BuildContext contet) {
        return CreateForm();
      });
    }
  }
}

class CreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
              bottom: 50.0,
              left: 40.0,
              right: 40.0,
            ),
            child: TextField(
              decoration: InputDecoration(hintText: 'What to do?'),
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  final text;
  bool _done = false;
  bool get done => _done;
  Task(this.text);
  toggle() {
    _done = !_done;
  }
}
