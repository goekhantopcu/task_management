import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/category/task.dart';
import 'package:task_management/notifier/group_controller.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/widgets/custom_appbar.dart';
import 'package:task_management/utils/global_state.dart';

class TaskCreation extends StatefulWidget {
  final Group group;

  const TaskCreation({Key key, this.group}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskCreationState();
}

class _TaskCreationState extends State<TaskCreation> {
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: _buildAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.transparent,
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: darkBlue2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    enabled: true,
                    autofocus: false,
                    onChanged: (value) {},
                    controller: contentController,
                    onSubmitted: (value) {},
                    style: TextStyle(
                      fontSize: 16,
                      color: lightGrey,
                      decoration: TextDecoration.none,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Content",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: lightGrey,
                        decoration: TextDecoration.none,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 110,
                  height: 50,
                  decoration: BoxDecoration(
                    color: darkBlue2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/star.svg",
                        height: 18,
                        width: 18,
                        color: Colors.pink,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Today",
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: darkBlue2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/tomorrow_icon.svg",
                        height: 20,
                        width: 20,
                        color: Colors.blue.shade700,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Tomorrow",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: darkBlue2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(13.0),
                    child: SvgPicture.asset(
                      "assets/calendar_empty.svg",
                      height: 14,
                      width: 14,
                      color: Color.fromRGBO(30, 188, 190, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    final GroupController controller = GlobalState.of(context);
    return CustomAppBar(
      hideLeading: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppBarBackButton(),
          Text(
            "Create New Task",
            style: TextStyle(
              fontSize: 23,
              color: lightGrey,
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/check.svg",
              color: Colors.white,
              width: 18,
              height: 18,
            ),
            onPressed: () {
              controller
                  .addTask(
                    super.widget.group,
                    Task(contentController.text, false, DateTime.now()),
                  )
                  .whenComplete(() => Navigator.of(context).pop());
            },
          ),
        ],
      ),
    );
  }
}
