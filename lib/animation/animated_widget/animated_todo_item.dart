import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  TodoItem({@required this.isDone});

  final bool isDone;

  @override
  TodoItemState createState() => TodoItemState();
}

class TodoItemState extends State<TodoItem> {
  bool isDone;

  @override
  void initState() {
    isDone = widget.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AnimatedDefaultTextStyle(
        duration: Duration(seconds: 1),
        curve: Curves.easeOutCirc,
        style: TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null,
            fontSize: isDone ? 12 : 16,
            color: isDone ? Colors.grey : Colors.black),
        child: Text('this is todo item'),
      ),
      trailing: AnimatedContainer(
        curve: Curves.bounceInOut,
        duration: Duration(milliseconds: 500),
        child: Icon(
          isDone ? Icons.check_box : Icons.check_box_outline_blank,
          size: isDone ? 16 : 18,
        ),
      ),
      onTap: () {
        setState(() {
          isDone = isDone == false;
        });
      },
    );
  }
}
