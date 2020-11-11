import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/utils/custom_appbar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = calculateDaysInterval({
      "start": DateTime.now(),
      "end": DateTime(2021, 1, 1),
    });

    int lastMonth = dates.first.month;

    return Scaffold(
      backgroundColor: darkBlue,
      appBar: CustomAppBar(
        title: Text(
          "Calendar",
          style: TextStyle(
            fontSize: 23,
            color: lightGrey,
          ),
        ),
      ),
      body: Container(
        color: Colors.transparent,
      ),
    );
  }

  Widget _buildDayEntry(DateTime date) {
    final DateTime now = DateTime.now();
    final bool selected =
        now.year == date.year && now.month == date.month && now.day == date.day;
    return Container(
      width: 55,
      height: 70,
      decoration: BoxDecoration(
        color: selected ? Color.fromRGBO(48, 104, 223, 1) : darkBlue2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.day.toString(),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat("E").format(date),
            style: TextStyle(
              fontSize: 12,
              color: selected ? Colors.white : Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> calculateDaysInterval(dynamic dateMap) {
    var startDate = dateMap["start"];
    var endDate = dateMap["end"];
    print(startDate.toString());
    print(endDate.toString());

    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }
}
