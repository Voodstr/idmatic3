import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class PersonWidget extends StatefulWidget {
  const PersonWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<PersonWidget> createState() => _PersonWidgetState();
}

class _PersonWidgetState extends State<PersonWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Персональная карточка");
  }
}