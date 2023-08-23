import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';

class TabBarWidget extends StatefulWidget {
  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
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
                title: const Text('Home'),
                selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(0);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Business'),
                selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('School'),
                selected: _selectedIndex == 2,
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
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text("IDMatic 3"),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}
