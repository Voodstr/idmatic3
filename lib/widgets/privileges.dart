import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class PrivilegesWidget extends StatefulWidget {
  const PrivilegesWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<PrivilegesWidget> createState() => _PrivilegesWidgetState();
}

class _PrivilegesWidgetState extends State<PrivilegesWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Администратор");
  }
}