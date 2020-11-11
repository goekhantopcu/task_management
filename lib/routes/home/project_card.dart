import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/category/task.dart';

class ProjectCard extends StatelessWidget {
  final Task task;
  final Group category;

  const ProjectCard({
    Key key,
    this.task,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(34, 34, 40, 1),
      ),
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 3,
                  style: BorderStyle.solid,
                  color: category.displayColor,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: category.displayColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text(
                category.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.9,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                task.title,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 5,
              ),
              child: Container(
                height: 30,
                width: 65,
                decoration: BoxDecoration(
                  color: category.displayColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Today".toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: category.displayColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
