import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/notifier/group_notifier.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/utils/custom_appbar.dart';
import 'package:task_management/utils/global_state.dart';

// ignore: must_be_immutable
class GroupSettings extends StatefulWidget {
  Group group;

  GroupSettings.empty();

  GroupSettings.withCategory(this.group);

  @override
  State<StatefulWidget> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  final TextEditingController nameController = TextEditingController();

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
    final GroupController controller = GlobalState.of(context);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleColorPicker(
                                initialColor: super.widget.group == null
                                    ? Colors.blue
                                    : super.widget.group.displayColor,
                                onChanged: (color) => _selectedColor = color,
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
                                        textBaseline: TextBaseline.alphabetic,
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
                                        textBaseline: TextBaseline.alphabetic,
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
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * 0.5,
        ),
        child: GestureDetector(
          onTap: () {
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
          child: Container(
            height: 60,
            width: double.infinity,
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
            child: Align(
              alignment: Alignment.center,
              child: Text(
                (widget.group == null ? "create" : "save").toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: Text(
        "Group Settings",
        style: TextStyle(
          fontSize: 20,
          color: lightGrey,
        ),
      ),
    );
  }
}
