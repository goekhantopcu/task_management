import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/category/task.dart';
import 'package:task_management/notifier/group_notifier.dart';
import 'package:task_management/utils/global_state.dart';
import 'package:task_management/widgets/task_card.dart';
import 'package:task_management/utils/utils.dart';

class TasksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GroupController controller = GlobalState.of(context);
    final List<Task> tasks = Utils.concatenate(
      controller.groups.map((group) => group.tasks).toList(),
    );
    tasks.sort((e1, e2) => e1.expireDate.compareTo(e2.expireDate));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tasks",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        for (int i = 0; i < tasks.length; i++)
          Column(
            children: [
              Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  height: 65,
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        "assets/delete.svg",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  if (direction.index == 2) {
                    controller.removeTask(tasks[i]);
                  }
                },
                key: Key("Task#${tasks[i].taskId}"),
                child: TaskEntry(
                  task: tasks[i],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
      ],
    );
  }
}
