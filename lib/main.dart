import 'package:flutter/material.dart'; 
const appTitle = 'YATODO';
const backgroundColor = Colors.white;
const textColor = Colors.black;

typedef void CreateFormCallback(String);

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: TasksRoute(),
    );
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
    return Scaffold(
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
          Task task = tasks[tasks.length - index - 1];
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
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return CreateForm(
                onSave: (newTodo) {
                  setState(() {
                    tasks.add(
                      Task(newTodo),
                    );
                  });
                },
              );
            }
          );
        },
      ),
    );
  }
}

class CreateForm extends StatefulWidget {
  final CreateFormCallback onSave;

  CreateForm({this.onSave});

  @override
  CreateFormState createState() => CreateFormState(onSave: this.onSave);
}

class CreateFormState extends State<CreateForm> {
  final _formKey = GlobalKey<FormState>();
  final CreateFormCallback onSave;

  CreateFormState({this.onSave});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'What to do?'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'No way to stay away!';
                        }
                      },
                      onSaved: (value) {
                        print('saving $value');
                        onSave(value);
                      },
                    ),
                  ),
                  FlatButton(
                    child: Text('Save'),
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Navigator.pop(context);
                      }
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
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
