import 'package:flutter/material.dart';
import 'widgets.dart';

class Journal extends PGStatefulWidget  {
  const Journal({super.key, required super.connection}) ;

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Журнал Событий");
  }
}

