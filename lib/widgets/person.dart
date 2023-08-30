import 'package:flutter/material.dart';
import 'package:idmatic3/widgets/widgets.dart';

class Person extends PGStatefulWidget {
  const Person({super.key, required super.connection});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("Персональная карточка");
  }
}