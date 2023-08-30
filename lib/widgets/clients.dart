import 'package:flutter/material.dart';
import 'package:idmatic3/widgets/widgets.dart';

class Clients extends PGStatefulWidget {
  const Clients({super.key, required super.connection});

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