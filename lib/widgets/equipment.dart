import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Equipment extends StatefulWidget {
  const Equipment({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Оборудование");
  }
}