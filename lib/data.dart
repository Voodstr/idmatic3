import 'package:flutter/material.dart';

//TODO создать структуру базы данных

class AccessLevel {
  int id = 0;
  String name = "default access level";
  String description = "default access level";
}

class Route {
  int id = 0;
  String name = "default access level";
  String description = "default access level";
  int timeZone = 1;
}

class Reader {}

class TimeZone {
  int id = 0;
  TimeOfDay beginTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);
}

//TODO метод формирования инт из двоичного



List<bool> privilegesToList(int privilegeInt,int size){
  List<bool> privilegesToList = [];
  for (int i = 0; i < (size - privilegeInt.toRadixString(2).length); i++) {
    privilegesToList.add(false);
  }
  privilegeInt.toRadixString(2).characters.forEach((e) {
    if (e == "1") {
      privilegesToList.add(true);
    } else {
      privilegesToList.add(false);
    }
  });
  var data = int.parse("source",radix: 2);
  return privilegesToList;
}