import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/notifier/group_notifier.dart';
import 'package:task_management/routes/group_settings/index.dart';
import 'package:task_management/routes/groups/group_card.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/widgets/custom_appbar.dart';
import 'package:task_management/utils/global_state.dart';
import 'package:task_management/widgets/notglowinglistview.dart';
import 'package:task_management/widgets/progress_section.dart';

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
        child: NotGlowingListView(
          content: ListView(
            children: [
              SizedBox(height: 20),
              ProgressSection(),
              SizedBox(height: 30),
              for (int index = 0; index < cards.length; index++) cards[index]
            ],
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      hideLeading: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppBarBackButton(),
          Text(
            "Groups",
            style: TextStyle(
              fontSize: 23,
              color: lightGrey,
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/plus.svg",
              color: Colors.white,
              width: 18,
              height: 18,
            ),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => GroupSettings.empty(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
