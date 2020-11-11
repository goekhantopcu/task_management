import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/notifier/group_controller.dart';
import 'package:task_management/routes/home/project_card.dart';
import 'package:task_management/utils/global_state.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroupController controller = GlobalState.of(context);
    final List<Group> groups =
        controller.groups.where((element) => element.tasks.isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  task: groups[index].tasks.first,
                  category: groups[index],
                ),
              );
            },
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
            itemCount: groups.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}
