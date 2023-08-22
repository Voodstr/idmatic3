
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final validLogin="123";
  final validPwd="123";
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController pwdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Column(mainAxisSize: MainAxisSize.min, children: [
      const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Вход в систему СКУД",
            textScaleFactor: 1.5,
          )),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextField(
          controller: loginTextController,
          decoration:
          const InputDecoration(border: OutlineInputBorder()),
          onEditingComplete: () => onValidLogin(checkLogin(loginTextController.text,pwdTextController.text),context),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextField(
          controller: pwdTextController,
          decoration:
          const InputDecoration(border: OutlineInputBorder()),
          onEditingComplete: () => onValidLogin(checkLogin(loginTextController.text,pwdTextController.text),context),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: TextButton(
                  onPressed: () => onValidLogin(checkLogin(loginTextController.text,pwdTextController.text),context),
                  child: const Text("OK"))),
        ]),
      ),
    ]);
  }

  checkLogin(pwd,login){
    if (pwd==validPwd && login==validLogin){
      return 1;
    } else {
      return 0;
    }
  }

  void onValidLogin(permissionLevel,BuildContext con){
      switch (permissionLevel){
        case 0: ScaffoldMessenger.of(con).clearSnackBars();ScaffoldMessenger.of(con).showSnackBar(const SnackBar(content: Text("Доступ запрещен")));
        case 1: ScaffoldMessenger.of(con).clearSnackBars();ScaffoldMessenger.of(con).showSnackBar(const SnackBar(content: Text("SUCCESS")));//TODO goto homePage
      }
  }

}