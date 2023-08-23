import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class _LoginScreenState extends State<LoginScreen> {

  final validLogin = "123";
  final validPwd = "202cb962ac59075b964b07152d234b70";
  final TextEditingController serverTextController = TextEditingController();
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController pwdTextController = TextEditingController();
  String defaultIP = "localhost";

  late PostgreSQLConnection _connection = PostgreSQLConnection(
      defaultIP, 5432, "mscd",
      username: "postgres", password: "pgsql");

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
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
    ]);
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
          onValidLogin(1);
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
      return 1; //"already open";
    } else {
      try {
        await _connection.open();
      } catch (e) {
        print("unable to connect: $e");
        return 2; //"unable to connect: $e";
      }
      print("connected to mscd");
      return 3; //"connected to mscd";
    }
  }

  void onValidLogin(permissionLevel) {
    switch (permissionLevel) {
      default:
      //TODO goto homePage
    }
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
