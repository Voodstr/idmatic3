import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Privileges extends StatefulWidget {
  const Privileges({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<Privileges> createState() => _PrivilegesState();
}

class _PrivilegesState extends State<Privileges> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Администратор");
  }
}