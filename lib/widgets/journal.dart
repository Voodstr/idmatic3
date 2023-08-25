import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
class Journal extends StatefulWidget {
  const Journal({super.key,required this.connection});
  final PostgreSQLConnection connection;

  @override
  State<Journal> createState() => _JournalState();
  }

class _JournalState extends State<Journal>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Журнал Событий");
  }
}