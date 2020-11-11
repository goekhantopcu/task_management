import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool center;
  final bool hideLeading;
  final Color background;

  const CustomAppBar({
    Key key,
    this.title,
    this.center = true,
    this.background = Colors.transparent,
    this.hideLeading = false,
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
          leading: this.hideLeading ? null : CustomAppBarBackButton(),
          automaticallyImplyLeading: !this.hideLeading,
          centerTitle: this.center,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}

class CustomAppBarBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20,
      ),
      onPressed: () {
        print("test");
        Navigator.of(context).pop();
      },
    );
  }
}
