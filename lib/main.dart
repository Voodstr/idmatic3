import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'package:postgres/postgres.dart';

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
  final validLogin = "123";
  final validPwd = "202cb962ac59075b964b07152d234b70";
  String defaultIP = "localhost";
  late PostgreSQLConnection _connection = PostgreSQLConnection(
      defaultIP, 5432, "mscd",
      username: "postgres", password: "pgsql");

  final TextEditingController serverTextController = TextEditingController();
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController pwdTextController = TextEditingController();
  int _selectedDrawerIndex = 0;
  String dbState = "offline";

  @override
  Widget build(BuildContext context) {
    if (dbState == "offline") {
      return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () => loginDialog(context),
            child: Text("ВХОД"),
          ),
        ),
      );
    } else {
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
                Text("IDMatic 3"),
                Spacer(),
                Text("dbstate: $dbState")
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

  void _onLogin(String text){
    setState(() {
      dbState = text;
    });
  }

  Future<int> checkLogin(String login, String pwd, BuildContext context) async {
    //TODO check server connection
    List<dynamic> qLogin;
    switch (await dbConnect(serverTextController.text)) {
      case 2:
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("db connection - error")));
        return 0;
      default:
        try {
          qLogin = await _connection.query(
              "SELECT name FROM tuser WHERE name = @aValue AND password = @bValue",
              substitutionValues: {"aValue": login, "bValue": pwd});
        } catch (e) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("db - ok, login - error")));
          return 2;
        }
        if (qLogin.isNotEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("SUCCESS")));
          Navigator.pop(context);
          return 1;
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("db - ok, login - error")));
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
      print("alredy open db connection");
      _onLogin("connected to ${serverTextController.text}");
      return 1; //"already open";
    } else {
      try {
        await _connection.open();
      } catch (e) {
        _onLogin("unable to connect to ${serverTextController.text} : $e");
        print("unable to connect: $e");
        return 2; //"unable to connect: $e";
      }
      print("connected to mscd");
      _onLogin("connected to ${serverTextController.text}");
      return 3; //"connected to mscd";
    }
  }
}
