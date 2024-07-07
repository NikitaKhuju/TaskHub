import 'package:flutter/material.dart';

String getMonth(int monthValue) {
  if (monthValue == 1) {
    return 'Jan';
  } else if (monthValue == 2) {
    return 'Feb';
  } else if (monthValue == 3) {
    return 'Mar';
  } else if (monthValue == 4) {
    return 'Apr';
  } else if (monthValue == 5) {
    return 'May';
  } else if (monthValue == 6) {
    return 'Jun';
  } else if (monthValue == 7) {
    return 'Jul';
  } else if (monthValue == 8) {
    return 'Aug';
  } else if (monthValue == 9) {
    return 'Sep';
  } else if (monthValue == 10) {
    return 'Oct';
  } else if (monthValue == 11) {
    return 'Nov';
  } else {
    return 'Dec';
  }
}

String twelveFormat(TimeOfDay time) {
  int hour = int.parse('$time'.split('(')[1].split(':')[0]);
  int minute = int.parse('$time'.split(':')[1].split(')')[0]);

  if (hour > 12) {
    hour -= 12;
    return '${hour}:${minute} pm';
  } else {
    return '${hour}:${minute} am';
  }
}
