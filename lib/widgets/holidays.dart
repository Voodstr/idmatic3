import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Holidays extends StatefulWidget {
  const Holidays({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<Holidays> createState() => _HolidaysState();
}

class _HolidaysState extends State<Holidays> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Календарь праздников");
  }
}