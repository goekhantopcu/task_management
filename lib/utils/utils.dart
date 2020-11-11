import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Utils {
  static final DateFormat onlyDate = DateFormat("dd.MM.yyyy");
  static final DateFormat dateWithTime = DateFormat("dd.MM.yyyy HH:mm");

  static Color calculateTextColor(Color background) {
    return background.computeLuminance() >= 0.5 ? Colors.black : Colors.white;
  }

  static List<T> concatenate<T>(List<List<T>> list) {
    final List<T> tmp = List();
    list.forEach((internList) {
      tmp.addAll(internList);
    });
    return tmp;
  }

  static String formatDate(DateTime dateTime) {
    if (dateTime == null) {
      dateTime = DateTime.now();
    }
    if (dateTime.hour == 0 && dateTime.minute == 0) {
      return onlyDate.format(dateTime);
    }
    return dateWithTime.format(dateTime);
  }

  static String formatTime(TimeOfDay timeOfDay) {
    final int hour = timeOfDay.hour;
    final int minute = timeOfDay.minute;
    return (hour <= 9 ? "0$hour" : "$hour") +
        ":" +
        (minute <= 9 ? "0$minute" : "$minute");
  }
}
