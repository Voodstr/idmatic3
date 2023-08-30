import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AccountingWidget extends StatefulWidget {
  const AccountingWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<AccountingWidget> createState() => _AccountingWidgetState();
}

class _AccountingWidgetState extends State<AccountingWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Учет рабочего времени");
  }
}