import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:idmatic3/widgets/widgets.dart';
import 'package:crypto/crypto.dart';

void main() {
  runApp(const IDMatic());
}

class IDMatic extends StatelessWidget {
  const IDMatic({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDMatic 3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const IDMaticMainPage(title: 'IDMatic 3'),
    );
  }
}

class IDMaticMainPage extends StatefulWidget {
  const IDMaticMainPage({super.key, required this.title});

  final String title;

  @override
  State<IDMaticMainPage> createState() => _IDMaticMainPageState();
}

class _IDMaticMainPageState extends State<IDMaticMainPage> {
  String defaultIP = "localhost";
  late PostgreSQLConnection _connection = PostgreSQLConnection(
      defaultIP, 5432, "mscd",
      username: "postgres", password: "pgsql");

  int _selectedDrawerIndex = 0;
  String _dbState = "Нет соединения";
  String currentUser = "";

  List<AdminPrivilege> adminList = [
    AdminPrivilege("Панель Администратора", false),
    AdminPrivilege("Персональная карточка", false),
    AdminPrivilege("Изменение ключей контроля доступа", false),
    AdminPrivilege("Изменение графиков работы", false),
    AdminPrivilege("Оборудование", false),
    AdminPrivilege("Календарь праздников", false),
    AdminPrivilege("Журнал событий", false),
    AdminPrivilege("Уровни доступа", false),
    AdminPrivilege("Внешние Клиенты", false),
    AdminPrivilege("Учёт рабочего времени", false)
  ];
  @override
  Widget build(BuildContext context) {
    List<AvailableWidget> mainWidgets = [
      AvailableWidget(
          "Журнал событий", Journal(connection: _connection), false),
      AvailableWidget(
          "Персональная карточка", Person(connection: _connection), false),
      AvailableWidget(
          "Уровни доступа", AccessLevel(connection: _connection), false),
      AvailableWidget(
          "Оборудование", Equipment(connection: _connection), false),
      AvailableWidget(
          "Календарь праздников", Holidays(connection: _connection), false),
      AvailableWidget(
          "Учёт рабочего времени", Accounting(connection: _connection), false),
      AvailableWidget(
          "Внешние Клиенты", Clients(connection: _connection), false),
      AvailableWidget(
          "Панель Администратора", Privileges(connection: _connection), false)
    ];
    for (var tab in mainWidgets) {
      if (adminList
          .any((elementOne) => elementOne.accessType == tab.widgetName)) {
        tab.available = adminList
            .firstWhere((elementTwo) => elementTwo.accessType == tab.widgetName)
            .available;
      }
    }
    if (_dbState == "Нет соединения") {
      return Scaffold(
        body: Center(
          heightFactor: 100.0,
          widthFactor: 100.0,
          child: TextButton(
            onPressed: () => loginDialog(context,
                (serv, login, pwd, ctx) => logIn(serv, login, pwd, ctx)),
            child: const Text(
              "ВХОД",
              textScaleFactor: 2.0,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: StatusTittle(dbState: _dbState, currentUser: currentUser),
            centerTitle: true,
          ),
          body: Center(
            child: mainWidgets[_selectedDrawerIndex].widget,
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(),
                    child: Text('IDMatic 3.0'),
                  ) as Widget
                ]
                    .followedBy(mainWidgets
                        .where((element) => element.available)
                        .map((e) => (ListTile(
                              title: Text(e.widgetName),
                              selected: _selectedDrawerIndex ==
                                  mainWidgets.indexOf(e),
                              onTap: () {
                                Navigator.pop(context);
                                _onItemTapped(mainWidgets.indexOf(e));
                              },
                            ))))
                    .followedBy([
                  ListTile(
                    title: const Text('Сменить пользователя'),
                    onTap: () {
                      Navigator.pop(context);
                      loginDialog(
                          context,
                          (serv, login, pwd, ctx) =>
                              logIn(serv, login, pwd, ctx));
                    },
                  ),
                  ListTile(
                    title: const Text('Выход'),
                    onTap: () {
                      // Update the state of the app
                      // Then close the drawer
                      Navigator.pop(context);
                      exit(0);
                    },
                  )
                ]).toList()),
          ));
    }
  }

  void loginDialog(
      BuildContext context,
      void Function(
              String server, String login, String pwd, BuildContext context)
          onComplete) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoginDialog(
            onComplete: onComplete,
            listOfServers: const ["localhost", "130.1.2.102"],
          ); //TODO получение списка серверов
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  void _dbStateChange(String text) {
    setState(() {
      _dbState = text;
    });
  }

  void _onSuccessfulLogin(String priv, String login) {
    setState(() {
      adminList = getAdminList(int.parse(priv.substring(1, priv.length - 1)));
      currentUser = login;
    });
  }

  logIn(String server, String login, String pwd, BuildContext context) async {
    List<dynamic> qPrivileges;
    switch (await dbConnect(server)) {
      case 2:
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ошибка подключения к БД")));
      default:
        try {
          qPrivileges = await _connection.query(
              "SELECT privilege FROM tuser WHERE name = @login AND password = @pwd",
              substitutionValues: {"login": login, "pwd": md5Hash(pwd)});
        } catch (e) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Ошибка входа")));
          return;
        }
        if (qPrivileges.isNotEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Подключено")));
          Navigator.pop(context);
          _onSuccessfulLogin(qPrivileges.first.toString(), login);
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Ошибка входа")));
        }
    }
  }

  Future<int> dbConnect(String ip) async {
    setState(() {
      _connection = PostgreSQLConnection(ip, 5432, "mscd",
          username: "postgres", password: "pgsql");
    });
    if (!_connection.isClosed) {
      _dbStateChange("Подключен к $ip");
      return 1; //"already open";
    } else {
      try {
        await _connection.open();
      } catch (e) {
        _dbStateChange("Невозможно подключиться к $ip : $e".substring(0, 50));
        return 2; //"unable to connect: $e";
      }
      _dbStateChange("Подключен к $ip");
      return 3; //"connected to mscd";
    }
  }

  List<AdminPrivilege> getAdminList(int privilegeInt) {
    List<AdminPrivilege> adminList = [
      AdminPrivilege("Панель Администратора", false),
      AdminPrivilege("Персональная карточка", false),
      AdminPrivilege("Изменение ключей контроля доступа", false),
      AdminPrivilege("Изменение графиков работы", false),
      AdminPrivilege("Оборудование", false),
      AdminPrivilege("Календарь праздников", false),
      AdminPrivilege("Журнал событий", false),
      AdminPrivilege("Уровни доступа", false),
      AdminPrivilege("Внешние Клиенты", false),
      AdminPrivilege("Учёт рабочего времени", false)
    ];
    List<bool> privilegesToList = [];
    for (int i = 0; i < (11 - privilegeInt.toRadixString(2).length); i++) {
      privilegesToList.add(false);
    }
    privilegeInt.toRadixString(2).characters.forEach((e) {
      if (e == "1") {
        privilegesToList.add(true);
      } else {
        privilegesToList.add(false);
      }
    });
    for (var element in adminList.indexed) {
      adminList[element.$1].available =
          privilegesToList.reversed.toList()[element.$1];
    }
    return adminList;
  }

  String md5Hash(String str) => md5.convert(utf8.encode(str)).toString();
}

class AvailableWidget {
  AvailableWidget(this.widgetName, this.widget, this.available);

  String widgetName;
  StatefulWidget widget;

  bool available = false;

  Widget tabTitleWidget() {
    return Tab(text: widgetName);
  }
}

class AdminPrivilege {
  AdminPrivilege(this.accessType, this.available);

  String accessType = "";
  bool available = false;
}
