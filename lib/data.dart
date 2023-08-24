import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:idmatic3/widgets/widgets.dart';
import 'package:crypto/crypto.dart';

class NamedTab {
  NamedTab(this.tabName, this.tabWidget, this.availability);

  String tabName = "0";
  Widget tabWidget = const Text("tabName");
  bool availability = false;
}

List<NamedTab> allTabs = [
  NamedTab("Журнал событий", Journal(), false),
  NamedTab("Персональная карточка", Person(), false),
  NamedTab("Уровни доступа", AccessLevel(), false),
  NamedTab("Оборудование", Equipment(), false),
  NamedTab("Праздники", Holidays(), false),
  NamedTab("Учет рабочего времени", Accounting(), false),
  NamedTab("Панель Администратора", Privileges(), false)
];

Map<String, bool> adminLevel = {
  "Администратор привилегий операторов": false,
  "Редактирование персональных данных": false,
  "Изменение ключей контроля доступа": false,
  "Изменение графиков работы": false,
  "Изменение считывателей системы": false,
  "Настройка календаря праздников": false,
  "Просмотр журнала событий": false,
  "Создание уровней доступа": false,
  "Список внешних клиентов": false,
  "Учёт рабочего времени": false,
};

String md5Hash(String str) => md5.convert(utf8.encode(str)).toString();

List<bool> privilegesToBoolList(int privilegeInt) {
  List<bool> _privilegesToList = [];
    for(int i=0; i<(11-privilegeInt.toRadixString(2).length); i++){
      _privilegesToList.add(false);
    }
  privilegeInt
      .toRadixString(2)
      .characters
      .forEach((e) {
    if (e == "1") {
      _privilegesToList.add(true);
    } else {
      _privilegesToList.add(false);
    }
  });
  return _privilegesToList.reversed.toList();
}
