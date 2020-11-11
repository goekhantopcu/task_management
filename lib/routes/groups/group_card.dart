import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/routes/group_settings/index.dart';
import 'package:task_management/utils/constants.dart';

class GroupCard extends StatelessWidget {
  final Group category;
  final bool editable;

  const GroupCard(
    this.category, {
    Key key,
    this.editable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        height: 90,
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: darkBlue2,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 7,
              margin: EdgeInsets.symmetric(
                vertical: 15,
              ),
              height: double.infinity,
              decoration: BoxDecoration(
                color: category.displayColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                margin: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 15,
                  right: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      category.name,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 17,
                        color: lightGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${category.tasks.where((e) => !e.completed).length} tasks",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (editable)
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(
                    Icons.edit,
                    size: 23,
                    color: Colors.grey.shade800,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => GroupSettings.withGroup(category),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
