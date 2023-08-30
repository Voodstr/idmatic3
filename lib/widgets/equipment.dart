import 'package:flutter/material.dart';
import 'package:idmatic3/widgets/widgets.dart';

class Equipment extends PGStatefulWidget {
  const Equipment({super.key, required super.connection});

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