
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';

class TabBarWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  DefaultTabController(
      initialIndex: 1,
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 2.0,
          bottom: const TabBar(
            indicatorColor: Colors.red,
            tabs: <Widget>[
              Tab(
                child: Text('Журнал событий', textAlign: TextAlign.center,textScaleFactor: 0.9,),
              ),
              Tab(
                child:
                Text('Персональная карточка', textAlign: TextAlign.center,textScaleFactor: 0.9,),
              ),
              Tab(
                child: Text('Уровни доступа', textAlign: TextAlign.center,textScaleFactor: 0.9,),
              ),
              Tab(
                child: Text('Оборудование', textAlign: TextAlign.center,textScaleFactor: 0.9,),
              ),
              Tab(
                child:
                Text('Календарь праздников', textAlign: TextAlign.center,textScaleFactor: 0.9,),
              ),
              Tab(
                child:
                Text('Учет рабочего времени', textAlign: TextAlign.center,textScaleFactor: 0.9,),
              ),
              Tab(
                child: Text('Администратор', textAlign: TextAlign.center,textScaleFactor: 0.9,),
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