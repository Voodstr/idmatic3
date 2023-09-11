import 'package:flutter/material.dart';

class Account {
  String ip;
  int port;
  String username;
  String password;
  int connectionTimeout;
  String email;
  bool sendPhoto;
  bool active;
  int? id;
  String name;

  Account(
      {this.ip = "",
      this.port = 0,
      this.username = "",
      this.password = "",
      this.connectionTimeout = 0,
      this.email = "",
      this.sendPhoto = true,
      this.active = true,
      this.name = ""});
}

class AccessLevel {
  int? id;
  String name;
  String description;

  AccessLevel(
      {this.name = "default access level",
      this.description = "default access level"});
}

//192.168.1.36 = 11000000 10101000 00000001 00100100
class Controller {
  String ip;
  String description;
  int? id;
  int ipInt;

  Controller({
    this.ip = "",
    this.description = "",
    this.ipInt = 0,
  });
}

class Event {
  int? id;
  String name;
  int importance;
  int number;

  Event({this.name = "", this.importance = 0, this.number = 0});
}

class Group {
  int? id;
  String description;
  int groupType;
  int blockTime;

  Group({this.description = "", this.groupType = 0, this.blockTime = 0});
}

class Holidays {
  int year;
  DateTime date;
  int dayOfWeek;
  int? id;

  Holidays(
      {this.year = 0, required this.date, this.dayOfWeek = 1, this.id = 0});
}

class Key {
  int number;
  bool ok;
  DateTime started;
  DateTime closed;
  DateTime update;
  int keyType; // 0 - радиокарта, 1 - wire, 2- QR code, 3 - штрих код
  int passType; // 0- постоянный, 1 - временный, 2 - разовый
  int pincode;
  int accessLevel;
  int? id;
  int personID;
  int personType; // 0- персонал, 1 - посетитель, 2 - автомобиль, 3 - список персон

  Key({
    this.number = 0,
    this.ok = false,
    required this.started,
    required this.closed,
    required this.update,
    this.keyType = 0,
    this.passType = 0,
    this.pincode = 0,
    this.accessLevel = 0,
    this.personID = 0,
    this.personType = 0,
  });
}

class Log {
  int? id;
  DateTime inputTime;
  DateTime realTime;
  String tpName;
  String eventName;
  String eventResult;
  String eventLevel;
  String fio;
  int key;
  int event;
  int result;
  int ip;
  int tp;
  int tpState;
  int eventStatus;
  String groupID;

  Log({
    required this.inputTime,
    required this.realTime,
    this.tpName = "",
    this.eventName = "",
    this.eventResult = "",
    this.eventLevel = "",
    this.fio = "",
    this.key = 0,
    this.event = 0,
    this.result = 0,
    this.ip = 0,
    this.tp = 0,
    this.tpState = 0,
    this.eventStatus = 0,
    this.groupID = "",
  });
}

class Pass {
  int personType; //0 -персонал 1 - посетитель
  String name;
  String surname;
  String patronymic;
  Image photo;
  DateTime update;
  List<String> personFiles;
  DateTime regdate;
  int? id;
  int uid;
  int schedule;

  Pass({
    this.personType = 0,
    this.name = "",
    this.surname = "",
    this.patronymic = "",
    required this.photo, //Image.memory(Uint8List(1)),
    required this.update,
    required this.personFiles,
    required this.regdate,
    this.uid = 0,
    this.schedule = 0,
  });
}

class PassParamList {
  int? id;
  String value;
  int nSel;

  PassParamList({this.value = "", this.nSel = 0});
}

class PassParameter {
  int? id;
  int passId;
  String name;
  String value;

  PassParameter({this.passId = 0, this.name = "", this.value = ""});
}

class PassStructure {
  int? id;
  int passId;
  int idName;
  int idData;

  PassStructure({
    this.passId = 0,
    this.idName = 0,
    this.idData = 0,
  });
}

class Reader {
  String name;
  String description;
  int tpType;
  int state;
  int groupID;
  int mode;
  int? id;
  int controller;
  int numberOnController;
  int tpFunction;

  Reader({
    this.name = "",
    this.description = "",
    this.tpType = 0,
    this.state = 0,
    this.groupID = 0,
    this.mode = 0,
    this.controller = 0,
    this.numberOnController = 0,
    this.tpFunction = 0,
  });
}

class ReadersList {
  int id = 0;
  int reader = 0;
  int route = 0;

  ReadersList({
    this.reader = 0,
    this.route = 0,
  });
}

class Result {
  int? id;
  int number;
  String result;

  Result({this.number = 0, this.result = ""});
}

class Destination {
  // Route
  int? id;
  String name;
  String description;
  int timeZone;

  Destination(
      {this.name = "default route",
      this.description = "default route",
      this.timeZone = 1});
}

class DestinationList {
  int? id;
  int accessLevel;
  int route;

  DestinationList({
    this.accessLevel = 0,
    this.route = 0,
  });
}

class Schedule {
  int? id;
  String name;
  TimeOfDay beginTime;
  TimeOfDay endTime;
  int week;

  Schedule(
      {this.name = "",
      required this.beginTime,
      required this.endTime,
      this.week = 0});
}

class StructureData {
  int? id;
  int structureID;
  String name;
  int nSel;

  StructureData({this.structureID = 0, this.name = "", this.nSel = 0});
}

class StructureList {
  int? id;
  String value;
  int nSel;

  StructureList({this.value = "", this.nSel = 0});
}

class TimeZone {
  String name;
  TimeOfDay beginTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);
  int week;
  int? id;
  int number;

  TimeZone({
    this.name = "",
    required this.beginTime,
    required this.endTime,
    this.week = 0,
    this.number = 0,
  });
}

class User {
  int privilege;
  String name;
  String password;
  bool allowance;
  int? id;

  User(
      {this.privilege = 2047,
      this.name = "",
      this.password = "",
      this.allowance = true,
      this.id = 0});
}

/*

    for (var element in (privilegeInt + 2048) //заполнение доступа из инта
        .toRadixString(2)
        .substring(2)
        .runes
        .toList()
        .reversed
        .map((e) => String.fromCharCode(e))
        .indexed) {
      adminList[element.$1].available = (element.$2 == "1");
    }
    return adminList;
  }
  String md5Hash(String str) => md5.convert(utf8.encode(str)).toString();


List<bool> privilegesToList(int privilegeInt,int size){
  List<bool> privilegesToList = [];
  for (int i = 0; i < (size - privilegeInt.toRadixString(2).length); i++) {
    privilegesToList.add(false);
  }
  privilegeInt.toRadixString(2).characters.forEach((e) {
    e == "1" ? privilegesToList.add(true) : privilegesToList.add(false);
  });
  return privilegesToList;
}

default class

class Result {
  String ip;
  DateTime started;
  TimeOfDay beginTime;
  Image photo;
  List<String> pfiles;
  int? id;
  bool ok;

  Result(
      {this.ip = "",
      required this.started,
      required this.beginTime,

      this.ok = false,
      required this.photo,
      required this.pfiles});
}


 */