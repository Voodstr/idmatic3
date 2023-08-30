import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AccessLevelWidget extends StatefulWidget {
  const AccessLevelWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<AccessLevelWidget> createState() => _AccessLevelWidgetState();
}

class _AccessLevelWidgetState extends State<AccessLevelWidget> {
  List<Widget>accessLevels =[Text("level1"),Text("data2"),Text("access3")];
  int selectedAccessLevel = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        persistentFooterButtons: [
          TextButton(
            onPressed: () => {onSavePress(context)},
            child:const Text("Изменить"),
          ),
          TextButton(
            onPressed: () => {onAdd(context)},
            child: const Text("Добавить"),
          ),
          TextButton(
            onPressed: () => {onDelete(context)},
            child: const Text("Удалить"),
          ),

        ],
        appBar: AppBar(
          toolbarHeight: 0.0,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Уровни доступа",
              ),
              Tab(
               text: "Маршруты",
              ),
              Tab(
                text: "Расписание",
              ),
              Tab(
                text: "Рабочее время",
              ),
              Tab(
                text: "Импорт пропусков",
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            ListView(children: accessLevels),
            Center(
              child: Text("Уровни доступа"),
            ),
            Center(
              child: Text("Маршруты"),
            ),
            Center(
              child: Text("Расписание"),
            ),
            Center(
              child: Text("Рабочее время"),
            ),
            Center(
              child: Text("Импорт пропусков"),
            ),

          ],
        ),
      ),
    );
  }

  onSavePress(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("onSavePress")));
  }

  onDelete(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("onDelete")));
  }

  onAdd(BuildContext context) {}
}

