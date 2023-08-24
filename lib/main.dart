import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'package:postgres/postgres.dart';
import 'package:idmatic3/data.dart' as data;

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'IDMatic 3'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String defaultIP = "localhost";
  late PostgreSQLConnection _connection = PostgreSQLConnection(
      defaultIP, 5432, "mscd",
      username: "postgres", password: "pgsql");

  final TextEditingController serverTextController = TextEditingController();
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController pwdTextController = TextEditingController();
  int _selectedDrawerIndex = 0;
  String _dbState = "Не подключено";
  int _priveleges = 0;

  @override
  Widget build(BuildContext context) {
    if (_dbState == "Не подключено") {
      return Scaffold(
        body: Center(
          heightFactor: 100.0,
          widthFactor: 100.0,
          child: TextButton(
            onPressed: () => loginDialog(context),
            child: const Text(
              "ВХОД",
              textScaleFactor: 2.0,
            ),
          ),
        ),
      );
    } else {
      //print(data.privilegesToBoolList(_priveleges));
      return DefaultTabController(
        initialIndex: 0,
        length: 7,
        child: Scaffold(
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
            title: Row(
              children: [
                const Text("IDMatic 3"),
                const Spacer(),
                Text("Состояние: $_dbState")
              ],
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.red,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Журнал событий',
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ),
                Tab(
                  child: Text(
                    'Персональная карточка',
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ),
                Tab(
                  child: Text(
                    'Уровни доступа',
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ),
                Tab(
                  child: Text(
                    'Оборудование',
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ),
                Tab(
                  child: Text(
                    'Календарь праздников',
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ),
                Tab(
                  child: Text(
                    'Учет рабочего времени',
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ),
                Tab(
                  child: Text(
                    'Администратор',
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ),
              ],
            ),
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
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Login'),
                  selected: _selectedDrawerIndex == 0,
                  onTap: () {
                    Navigator.pop(context);
                    loginDialog(context);
                  },
                ),
                ListTile(
                  title: const Text('Business'),
                  selected: _selectedDrawerIndex == 1,
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(1);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('School'),
                  selected: _selectedDrawerIndex == 2,
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(2);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              Journal(),
              Person(),
              AccessLevel(),
              Equipment(),
              Holidays(),
              Accounting(),
              Privileges(),
            ],
          ),
        ),
      );
    }
  }

  void loginDialog(BuildContext context) {
    //TODO вынести в отдельный элемент
    serverTextController.text = defaultIP; //TODO добавить список ip адресов
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Вход в систему СКУД",
                  textScaleFactor: 1.5,
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: serverTextController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onEditingComplete: () => checkLogin(
                    loginTextController.text, pwdTextController.text, context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: loginTextController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onEditingComplete: () => checkLogin(
                    loginTextController.text, pwdTextController.text, context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: pwdTextController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onEditingComplete: () => checkLogin(
                    loginTextController.text, pwdTextController.text, context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                    child: TextButton(
                        onPressed: () => checkLogin(loginTextController.text,
                            pwdTextController.text, context),
                        child: const Text("OK"))),
              ]),
            ),
          ]));
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  void _onLogin(String text) {
    setState(() {
      _dbState = text;
    });
  }

  void _onPrivilegesChange(String priv) {
    setState(() {
      _priveleges = int.parse(priv.substring(1, priv.length - 1));
    });
  }

  Future<int> checkLogin(String login, String pwd, BuildContext context) async {
    List<dynamic> qPrivileges;
    switch (await dbConnect(serverTextController.text)) {
      case 2:
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ошибка подключения к БД")));
        return 0;
      default:
        try {
          qPrivileges = await _connection.query(
              "SELECT privilege FROM tuser WHERE name = @aValue AND password = @bValue",
              substitutionValues: {"aValue": login, "bValue": data.md5Hash(pwd)});
        } catch (e) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Ошибка входа")));
          return 2;
        }
        if (qPrivileges.isNotEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Подключено")));
          Navigator.pop(context);
          _onPrivilegesChange(qPrivileges.first.toString());
          return 1;
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Ошибка входа")));
          return 2;
        }
    }
  }

  Future<int> dbConnect(String ip) async {
    setState(() {
      _connection = PostgreSQLConnection(ip, 5432, "mscd",
          username: "postgres", password: "pgsql");
    });
    if (!_connection.isClosed) {
      _onLogin("Подключен к ${serverTextController.text}");
      return 1; //"already open";
    } else {
      try {
        await _connection.open();
      } catch (e) {
        _onLogin("Невозможно подключиться к ${serverTextController.text} : $e"
            .substring(0, 50));
        return 2; //"unable to connect: $e";
      }
      _onLogin("Подключен к ${serverTextController.text}");
      return 3; //"connected to mscd";
    }
  }
}

