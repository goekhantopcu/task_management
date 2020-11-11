import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management/category/task.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/utils/global_state.dart';

class TaskEntry extends StatelessWidget {
  final Task task;

  const TaskEntry({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: darkBlue2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              task.completed = !task.completed;
              GlobalState.of(context).updateTask(task);
            },
            child: Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                color: task.completed ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 3,
                  style: BorderStyle.solid,
                  color: task.completed
                      ? Colors.green
                      : Color.fromRGBO(80, 81, 85, 1),
                ),
              ),
              child: Visibility(
                visible: task.completed,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                task.title,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 18,
                  color: lightGrey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
