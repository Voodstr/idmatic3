import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Clients extends StatefulWidget {
  const Clients({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Внешние клиенты");
  }
}