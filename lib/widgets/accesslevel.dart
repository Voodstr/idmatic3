import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AccessLevel extends StatefulWidget {
  const AccessLevel({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<AccessLevel> createState() => _AccessLevelState();
}

class _AccessLevelState extends State<AccessLevel> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Уровни доступа");
  }
}