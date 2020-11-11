import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/notifier/group_controller.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/widgets/custom_appbar.dart';
import 'package:task_management/utils/global_state.dart';

// ignore: must_be_immutable
class GroupSettings extends StatefulWidget {
  Group group;

  GroupSettings.empty();

  GroupSettings.withGroup(this.group);

  @override
  State<StatefulWidget> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  final TextEditingController nameController = TextEditingController();
  GlobalKey<AnimatorWidgetState> _animation = GlobalKey<AnimatorWidgetState>();

  Color _selectedColor = Colors.white;

  @override
  void initState() {
    if (super.widget.group != null) {
      _selectedColor = super.widget.group.displayColor;
      nameController.text = super.widget.group.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: _buildAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                HeadShake(
                  preferences: AnimationPreferences(
                    autoPlay: AnimationPlayStates.None,
                  ),
                  key: _animation,
                  child: Container(
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
                          controller: nameController,
                          onSubmitted: (value) {},
                          style: TextStyle(
                            fontSize: 16,
                            color: lightGrey,
                            decoration: TextDecoration.none,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
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
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          elevation: 0.0,
                          backgroundColor: darkBlue2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 400,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleColorPicker(
                                    initialColor: super.widget.group == null
                                        ? Colors.blue
                                        : super.widget.group.displayColor,
                                    onChanged: (color) =>
                                        _selectedColor = color,
                                    size: const Size(240, 240),
                                    strokeWidth: 4,
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: lightGrey,
                                      decoration: TextDecoration.none,
                                      textBaseline: TextBaseline.alphabetic,
                                    ),
                                    thumbSize: 36,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            decoration: TextDecoration.none,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Select",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: lightGrey,
                                            decoration: TextDecoration.none,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: darkBlue2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/color_picker.svg",
                                width: 30,
                                height: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Group Color",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: lightGrey,
                                    decoration: TextDecoration.none,
                                    textBaseline: TextBaseline.alphabetic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade400,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (super.widget.group != null)
              GestureDetector(
                onTap: () {
                  GlobalState.of(context).removeGroup(super.widget.group);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Delete group",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                    ),
                  ),
                ),
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
            "Group " + (super.widget.group != null ? "Settings" : "Creation"),
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
              if (nameController.text.isEmpty) {
                _animation.currentState.animator.forward();
                return;
              }
              if (super.widget.group == null) {
                super.widget.group = Group(
                  nameController.text,
                  _selectedColor,
                );
                controller.addGroup(super.widget.group);
              } else {
                super.widget.group.name = nameController.text;
                super.widget.group.displayColor = _selectedColor;
                controller.updateGroup(super.widget.group);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
