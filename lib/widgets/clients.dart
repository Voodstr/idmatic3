import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class ClientsWidget extends StatefulWidget {
  const ClientsWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<ClientsWidget> createState() => _ClientsWidgetState();
}

class _ClientsWidgetState extends State<ClientsWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Внешние клиенты");
  }
}