import 'package:flutter/material.dart';
import 'package:idmatic3/widgets/widgets.dart';

class Accounting extends PGStatefulWidget {
  const Accounting({super.key, required super.connection});


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