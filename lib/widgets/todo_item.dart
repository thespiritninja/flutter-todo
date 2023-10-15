import 'package:flutter/material.dart';
import 'package:todoapp/model/model.dart';
import 'package:todoapp/utils/colors.dart';

class TodoItem extends StatelessWidget {
  final ToDo toDo;
  final onTodoChanged;
  final onTodoDeleted;
  const TodoItem(
      {Key? key,
      required this.toDo,
      required this.onTodoChanged,
      required this.onTodoDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print("Clicked on the tile!");
          onTodoChanged(toDo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white70,
        leading: Icon(
          toDo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(toDo.todoText!,
            style: TextStyle(
                fontSize: 15,
                color: tdBlack,
                decoration: toDo.isDone ? TextDecoration.lineThrough : null)),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(7),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 20,
            icon: Icon(Icons.delete),
            onPressed: () {
              print("Delete Pressed");
              onTodoDeleted(toDo.id);
            },
          ),
        ),
      ),
    );
  }
}
