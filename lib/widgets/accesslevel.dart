import 'package:flutter/material.dart';
import 'package:idmatic3/widgets/widgets.dart';

class AccessLevel extends PGStatefulWidget {
  const AccessLevel({super.key, required super.connection});


  @override
  State<AccessLevel> createState() => _AccessLevelState();
}

class _AccessLevelState extends State<AccessLevel> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Уровни доступа");
  }
}