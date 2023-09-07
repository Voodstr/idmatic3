import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
class JournalWidget extends StatefulWidget {
  const JournalWidget({super.key,required this.connection});
  final PostgreSQLConnection connection;

  @override
  State<JournalWidget> createState() => _JournalWidgetState();
  }

class _JournalWidgetState extends State<JournalWidget>{
  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return const Text("Журнал Событий");
  }
}

