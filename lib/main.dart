import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_management/database/database.dart';
import 'package:task_management/notifier/group_controller.dart';
import 'package:task_management/routes/home/index.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/utils/global_state.dart';

void main() async {
  final DatabaseConnector connector = DatabaseConnector();
  await connector.open();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: darkBlue,
      systemNavigationBarColor: darkBlue,
    ),
  );
  runApp(TaskManagementApp(connector));
}

class TaskManagementApp extends StatelessWidget {
  final DatabaseConnector _connector;

  TaskManagementApp(this._connector);

  @override
  Widget build(BuildContext context) {
    return GlobalState(
      GroupController(this._connector),
      child: MaterialApp(
        title: 'Task Management',
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
