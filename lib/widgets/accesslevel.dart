import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AccessLevelWidget extends StatefulWidget {
  const AccessLevelWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<AccessLevelWidget> createState() => _AccessLevelWidgetState();
}

//TODO все списки и данные из БД сформировать в виде FutureWidget
//TODO Элементы класть в контейнеры, вместо padding

class _AccessLevelWidgetState extends State<AccessLevelWidget> {
  List<Widget>accessLevels =[Text("level1"),Text("data2"),Text("access3")];
  int selectedAccessLevel = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
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
        body:  const TabBarView(
          children: <Widget>[
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
            )

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

