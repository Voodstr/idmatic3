import 'package:flutter/material.dart';

class LoginDialog extends StatelessWidget {
  final List<String> listOfServers;

  LoginDialog(
      {super.key,
      required this.onComplete,

      this.listOfServers = const ["localhost"]});

  //TODO поменять диалог на полноэкранный если размер экрана телефон/планшет
  //TODO можно сделать виджет в виде <Form>
  final TextEditingController serverTextController = TextEditingController();
  final TextEditingController pwdTextController = TextEditingController();
  final TextEditingController loginTextController = TextEditingController();

  final void Function(
      String server, String login, String pwd, BuildContext context) onComplete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
         Container(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              "Вход в систему СКУД",
              textScaleFactor: 1.5,
            )),
        Container(
            padding: const EdgeInsets.all(12.0),
            child: DropdownMenu<String>(
              controller: serverTextController,
              hintText: "Адрес сервера СКУД",
              initialSelection: listOfServers.first,
              dropdownMenuEntries:
                  listOfServers.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            )),
        Container(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
              controller: loginTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Имя пользователя"),
              onEditingComplete: () => {
                    onComplete(
                        serverTextController.text,
                        loginTextController.text,
                        pwdTextController.text,
                        context)
                  }),
        ),
        Container(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
              obscureText: true,
              controller: pwdTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Пароль"),
              onEditingComplete: () => {
                    onComplete(
                        serverTextController.text,
                        loginTextController.text,
                        pwdTextController.text,
                        context)
                  }),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: TextButton(
                    onPressed: () => {
                          onComplete(
                              serverTextController.text,
                              loginTextController.text,
                              pwdTextController.text,
                              context)
                        },
                    child: const Text("Вход"))),
          ]),
        ),
      ]),
    );
  }
}

