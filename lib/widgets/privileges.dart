import 'package:flutter/material.dart';
import 'package:idmatic3/widgets/widgets.dart';

class Privileges extends PGStatefulWidget {
  const Privileges({super.key, required super.connection});


  @override
  State<Privileges> createState() => _PrivilegesState();
}

class _PrivilegesState extends State<Privileges> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Администратор");
  }
}