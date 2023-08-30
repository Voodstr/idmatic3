import 'package:flutter/material.dart';
import 'package:idmatic3/widgets/widgets.dart';

class Holidays extends PGStatefulWidget {
  const Holidays({super.key, required super.connection});

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