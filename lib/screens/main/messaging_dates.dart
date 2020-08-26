import 'package:flutter/material.dart';
import 'message_text.dart';

String processTime(String time) {
  List<String> dateAndTime = time.split(' ');
  List<String> times = dateAndTime[1].split(':');
  String fullEdit = '';

  if (int.parse(times[0]) > 12) {
    fullEdit = (int.parse(times[0]) - 12).toString();
    fullEdit += ':' + times[1] + ' p.m.';
  } else {
    fullEdit = times[0] + ':' + times[1] + ' a.m.';
  }

  return fullEdit;
}

List<Widget> separateDate(List<MessageText> messages) {
  if (messages.isEmpty) {
    return [];
  }

  List<Widget> widgets = [];

  if (DateTime.now().difference(messages[0].date).inDays > 7) {
    if (messages[0].date.year == DateTime.now().year) {
      widgets.add(Center(
          child: Text(
        getDate(messages[0].date.month, messages[0].date.day,
            messages[0].date.year, messages[0].date.weekday, false),
        style: TextStyle(color: Colors.black54),
      )));
    } else {
      widgets.add(Center(
          child: Text(
        getDate(messages[0].date.month, messages[0].date.day,
            messages[0].date.year, messages[0].date.weekday, true),
        style: TextStyle(color: Colors.black54),
      )));
    }
  } else {
    if (DateTime.now().day - messages[0].date.day == 0) {
      widgets.add(Center(
          child: Text(
        'Today',
        style: TextStyle(color: Colors.black54),
      )));
    } else if (DateTime.now().day - messages[0].date.day == 1) {
      widgets.add(Center(
          child: Text(
        'Yesterday',
        style: TextStyle(color: Colors.black54),
      )));
    } else {
      widgets.add(Center(
          child: Text(
        getWeekday(messages[0].date.weekday),
        style: TextStyle(color: Colors.black54),
      )));
    }
  }

  for (int i = 0; i < messages.length - 1; i++) {
    widgets.add(messages[i]);

    if (isOnADifferentDay(messages[i + 1].date, messages[i].date)) {
      if (DateTime.now().difference(messages[i + 1].date).inDays > 7) {
        if (DateTime.now().year == messages[i + 1].date.year) {
          widgets.add(Center(
              child: Text(
            getDate(messages[i + 1].date.month, messages[i + 1].date.day,
                messages[i + 1].date.year, messages[i + 1].date.weekday, false),
            style: TextStyle(color: Colors.black54),
          )));
        } else {
          widgets.add(Center(
              child: Text(
            getDate(messages[i + 1].date.month, messages[i + 1].date.day,
                messages[i + 1].date.year, messages[i + 1].date.weekday, true),
            style: TextStyle(color: Colors.black54),
          )));
        }
      } else {
        if (DateTime.now().day - messages[i + 1].date.day == 0) {
          widgets.add(Center(
              child: Text(
            'Today',
            style: TextStyle(color: Colors.black54),
          )));
        } else if (DateTime.now().day - messages[i + 1].date.day == 1) {
          widgets.add(Center(
              child: Text(
            'Yesterday',
            style: TextStyle(color: Colors.black54),
          )));
        } else {
          widgets.add(Center(
              child: Text(
            getWeekday(messages[i + 1].date.weekday),
            style: TextStyle(color: Colors.black54),
          )));
        }
      }
    }
  }

  widgets.add(messages.last);
  return widgets;
}

String getFullDateAsString(DateTime time) {
  if (DateTime.now().difference(time).inDays > 7) {
    if (time.year == DateTime.now().year) {
      return getDate(time.month, time.day, time.year, time.weekday, false);
    } else {
      return getDate(time.month, time.day, time.year, time.weekday, true);
    }
  } else {
    if (DateTime.now().day - time.day == 0) {
      return 'Today';
    } else if (DateTime.now().day - time.day == 1) {
      return 'Yesterday';
    } else {
      return getWeekday(time.weekday);
    }
  }
}

String getDate(int month, int day, int year, int weekDay, bool displayYear) {
  String monthS = '';

  switch (month) {
    case 1:
      monthS = 'Jan.';
      break;
    case 2:
      monthS = 'Feb.';
      break;
    case 3:
      monthS = 'Mar.';
      break;
    case 4:
      monthS = 'Apr.';
      break;
    case 5:
      monthS = 'May.';
      break;
    case 6:
      monthS = 'June';
      break;
    case 7:
      monthS = 'July';
      break;
    case 8:
      monthS = 'Aug.';
      break;
    case 9:
      monthS = 'Sep.';
      break;
    case 10:
      monthS = 'Oct.';
      break;
    case 11:
      monthS = 'Nov.';
      break;
    case 12:
      monthS = 'Dec.';
      break;
    default:
      break;
  }

  return getWeekday(weekDay) +
      ', ' +
      monthS +
      ' ' +
      day.toString() +
      (displayYear ? ', ' + year.toString() : '');
}

String getWeekday(int weekDay) {
  switch (weekDay) {
    case 1:
      return 'Monday';
      break;
    case 2:
      return 'Tuesday';
      break;
    case 3:
      return 'Wednesday';
      break;
    case 4:
      return 'Thursday';
      break;
    case 5:
      return 'Friday';
      break;
    case 6:
      return 'Saturday';
      break;
    case 7:
      return 'Sunday';
      break;
    default:
      return '';
  }
}

bool isOnADifferentDay(DateTime time1, DateTime time2) {
  if (time1.year == time2.year) {
    if (time1.month == time2.month) {
      if (time1.day == time2.day) {
        return false;
      }
    }
  }

  return true;
}
