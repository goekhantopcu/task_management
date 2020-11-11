import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool center;
  final Color background;

  const CustomAppBar({
    Key key,
    this.title,
    this.center = true,
    this.background = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkBlue2,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
        ),
        child: AppBar(
          elevation: 0.0,
          title: this.title,
          centerTitle: this.center,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}
