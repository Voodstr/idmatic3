import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class EquipmentWidget extends StatefulWidget {
  const EquipmentWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<EquipmentWidget> createState() => _EquipmentWidgetState();
}

class _EquipmentWidgetState extends State<EquipmentWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Оборудование");
  }
}