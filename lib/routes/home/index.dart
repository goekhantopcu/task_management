import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/category/task.dart';
import 'package:task_management/notifier/group_notifier.dart';
import 'package:task_management/routes/calendar/index.dart';
import 'package:task_management/routes/groups/group_card.dart';
import 'package:task_management/routes/groups/index.dart';
import 'package:task_management/routes/task_create/index.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/utils/custom_appbar.dart';
import 'package:task_management/utils/global_state.dart';
import 'package:task_management/utils/notglowinglistview.dart';
import 'package:task_management/utils/utils.dart';

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
              _buildProgressSection(),
              _buildProjectsSection(),
              _buildTasksSection(),
            ],
            physics: BouncingScrollPhysics(),
          ),
        ),
        margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 0.0,
            onPressed: () {
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
                                (e) => GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) => TaskCreation(
                                          category: e,
                                        ),
                                      ),
                                    );
                                  },
                                  child: GroupCard(e, editable: false),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
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
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    final DateTime now = DateTime.now();
    return CustomAppBar(
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

  Widget _buildTasksSection() {
    final GroupController controller = GlobalState.of(context);
    final List<Task> tasks = Utils.concatenate(
      controller.groups.map((e) => e.tasks).toList(),
    );
    tasks.sort((e1, e2) => e1.expireDate.compareTo(e2.expireDate));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          "Tasks",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        for (int i = 0; i < tasks.length; i++) _buildTaskEntry(tasks[i]),
      ],
    );
  }

  Widget _buildTaskEntry(Task task) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
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
      ),
    );
  }

  Widget _buildProjectsSection() {
    final Group firstCategory = Group(
      "Meetings",
      Color.fromRGBO(254, 115, 72, 1),
    );
    final Task firstTask = Task("Amanda at Ruth's", false, DateTime.now());

    final Group secondCategory = Group(
      "Trip",
      Color.fromRGBO(99, 244, 247, 1),
    );
    final Task secondTask = Task("Holidays in Norway", false, DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          "Projects",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 220,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 160,
                child: ProjectCard(
                  task: index % 2 == 0 ? secondTask : firstTask,
                  category: index % 2 == 0 ? secondCategory : firstCategory,
                ),
              );
            },
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
            itemCount: 100,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 20);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: darkBlue2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 70.0,
                    lineWidth: 7.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 7.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.4,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(254, 115, 72, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 125.0,
                    lineWidth: 7.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.7,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(48, 104, 224, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 200,
              margin: EdgeInsets.only(
                right: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(48, 104, 224, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Inbox",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "70%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(254, 115, 72, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Meetings",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "40%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(99, 244, 247, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Trip",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "80%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
