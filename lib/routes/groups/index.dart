import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_management/notifier/group_notifier.dart';
import 'package:task_management/routes/group_settings/index.dart';
import 'package:task_management/routes/groups/group_card.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/utils/custom_appbar.dart';
import 'package:task_management/utils/global_state.dart';
import 'package:task_management/utils/notglowinglistview.dart';

class GroupsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  void didChangeDependencies() {
    GlobalState.of(context).addListener(_updateState);
    super.didChangeDependencies();
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
    final List<GroupCard> cards =
        controller.groups.map((e) => GroupCard(e, editable: true)).toList();

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: darkBlue,
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(bottom: 75),
          child: NotGlowingListView(
            content: ListView(
              children: [
                SizedBox(height: 20),
                _buildProgressSection(),
                SizedBox(height: 30),
                for (int index = 0; index < cards.length; index++) cards[index]
              ],
              physics: BouncingScrollPhysics(),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 25,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => GroupSettings.empty(),
              ),
            );
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(48, 104, 223, 1),
                  Color.fromRGBO(41, 84, 174, 1)
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/plus.svg",
                  height: 15,
                  width: 15,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "create new group".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: Text(
        "Groups",
        style: TextStyle(
          fontSize: 23,
          color: lightGrey,
        ),
      ),
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
                    radius: 25.0,
                    lineWidth: 3.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 45.0,
                    lineWidth: 3.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 65.0,
                    lineWidth: 3.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 85.0,
                    lineWidth: 3.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 105.0,
                    lineWidth: 5.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.4,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(254, 115, 72, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 125.0,
                    lineWidth: 5.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.7,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(48, 104, 224, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 145.0,
                    lineWidth: 5.0,
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
