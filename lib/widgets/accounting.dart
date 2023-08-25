import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Accounting extends StatefulWidget {
  const Accounting({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<Accounting> createState() => _AccountingState();
}

class _AccountingState extends State<Accounting> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Учет рабочего времени");
  }
}