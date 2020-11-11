import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:task_management/notifier/group_notifier.dart';
import 'package:task_management/routes/calendar/index.dart';
import 'package:task_management/routes/groups/group_card.dart';
import 'package:task_management/routes/groups/index.dart';
import 'package:task_management/routes/home/projects_section.dart';
import 'package:task_management/routes/home/tasks_section.dart';
import 'package:task_management/routes/task_create/index.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/widgets/custom_appbar.dart';
import 'package:task_management/utils/global_state.dart';
import 'package:task_management/widgets/notglowinglistview.dart';
import 'package:task_management/widgets/progress_section.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    final GroupController controller = GlobalState.of(context);
    controller.loadGroups().whenComplete(() => super.didChangeDependencies());
    controller.addListener(_updateState);
  }

  @override
  void dispose() {
    GlobalState.of(context).removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GroupController controller = GlobalState.of(context);

    return Scaffold(
      backgroundColor: darkBlue,
      appBar: _buildAppBar(context),
      body: Container(
        color: Colors.transparent,
        child: NotGlowingListView(
          content: ListView(
            children: [
              SizedBox(height: 20),
              ProgressSection(),
              SizedBox(height: 30),
              ProjectsSection(),
              SizedBox(height: 30),
              TasksSection(),
            ],
            physics: BouncingScrollPhysics(),
          ),
        ),
        margin: EdgeInsets.only(left: 25, right: 25),
      ),
      floatingActionButton: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 0.0,
            onPressed: () => _buildDialog(controller),
            backgroundColor: Color.fromRGBO(48, 104, 223, 1),
            child: SvgPicture.asset(
              "assets/plus.svg",
              height: 20,
              width: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _buildDialog(GroupController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: darkBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 500,
            margin: EdgeInsets.all(15),
            child: NotGlowingListView(
              content: ListView(
                children: controller.groups
                    .map(
                      (group) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => TaskCreation(group: group),
                            ),
                          );
                        },
                        child: GroupCard(group, editable: false),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    final DateTime now = DateTime.now();
    return CustomAppBar(
      hideLeading: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/appbar/menu.svg",
              width: 23,
              height: 23,
              color: lightGrey,
            ),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => GroupsPage(),
                ),
              );
            },
          ),
          Text(
            "${DateFormat("EEEE, d").format(now)}",
            style: TextStyle(
              fontSize: 23,
              color: lightGrey,
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/appbar/calendar.svg",
              width: 23,
              height: 23,
              color: lightGrey,
            ),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => CalendarPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
