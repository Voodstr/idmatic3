import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Person extends StatefulWidget {
  const Person({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Персональная карточка");
  }
}