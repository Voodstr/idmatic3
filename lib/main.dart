import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:idmatic3/widgets/widgets.dart';
import 'package:crypto/crypto.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('IDMatic 3');
    setWindowMinSize(const Size(1280, 720));
  }

  runApp(const IDMatic());
}

class IDMatic extends StatelessWidget {
  const IDMatic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDMatic 3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const IDMaticMainPage(),
    );
  }
}

class IDMaticMainPage extends StatefulWidget {
  const IDMaticMainPage({super.key});

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
          "Внешние Клиенты", ClientsWidget(connection: _connection), false),
      AvailableWidget("Персональная карточка",
          PersonWidget(connection: _connection), false),
      AvailableWidget(
          "Журнал событий", JournalWidget(connection: _connection), false),
      AvailableWidget(
          "Уровни доступа", AccessLevelWidget(connection: _connection), false),
      AvailableWidget(
          "Оборудование", EquipmentWidget(connection: _connection), false),
      AvailableWidget("Календарь праздников",
          HolidaysWidget(connection: _connection), false),
      AvailableWidget("Учёт рабочего времени",
          AccountingWidget(connection: _connection), false),
      AvailableWidget("Панель Администратора",
          PrivilegesWidget(connection: _connection), false)
    ];
    for (var tab in mainWidgets) {
      if (adminList
          .any((elementOne) => elementOne.accessType == tab.widgetName)) {
        tab.available = adminList
            .firstWhere((elementTwo) => elementTwo.accessType == tab.widgetName)
            .available;
      }
    }
    if (!_dbState.startsWith("П")) {
      return Scaffold(
        body: Center(
          heightFactor: 100.0,
          widthFactor: 100.0,
          child: TextButton(
            onPressed: () =>
                loginDialog(context, (serv, login, pwd, ctx) => fastLogin(ctx)),
            //logIn(serv, login, pwd, ctx)),
            //TODO вернуть на нормальные
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
                ),
                ...mainWidgets.where((element) => element.available).map((e) =>
                    (ListTile(
                        title: Text(e.widgetName),
                        selected:
                            _selectedDrawerIndex == mainWidgets.indexOf(e),
                        onTap: () {
                          Navigator.pop(context);
                          _onItemTapped(mainWidgets.indexOf(e));
                        }))),
                ListTile(
                    title: const Text('Сменить пользователя'),
                    onTap: () {
                      Navigator.pop(context);
                      loginDialog(
                          context,
                          (serv, login, pwd, ctx) =>
                              logIn(serv, login, pwd, ctx));
                    }),
                ListTile(
                  title: const Text('Выход'),
                  onTap: () {
                    // Update the state of the app
                    // Then close the drawer
                    _connection.close();
                    Navigator.pop(context);
                    exit(0);
                  },
                )
              ])));
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
      adminList = updateAdminList(int.parse(priv.substring(
          1,
          priv.length -
              1))); //Строку укорачиваю с обоих концов т.к. возвращает "[значение]"
      currentUser = login;
    });
  }

  void fastLogin(BuildContext context) {
    logIn("localhost", "admin", "123", context);
  }

  void logIn(
      String server, String login, String pwd, BuildContext context) async {
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
              .showSnackBar(SnackBar(content: Text("Ошибка входа $e")));
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

  List<AdminPrivilege> updateAdminList(int privilegeInt) {
    for (var element in (privilegeInt + 2048)
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
}

class AvailableWidget {
  AvailableWidget(this.widgetName, this.widget, this.available);

  String widgetName;
  StatefulWidget widget;
  bool available = false;
}

class AdminPrivilege {
  AdminPrivilege(this.accessType, this.available);

  String accessType = "";
  bool available = false;
}
