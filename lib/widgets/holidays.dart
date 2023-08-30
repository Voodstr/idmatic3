import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class HolidaysWidget extends StatefulWidget {
  const HolidaysWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<HolidaysWidget> createState() => _HolidaysWidgetState();
}

class _HolidaysWidgetState extends State<HolidaysWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Календарь праздников");
  }
}