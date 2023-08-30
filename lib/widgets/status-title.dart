import 'package:flutter/material.dart';

class StatusTittle extends StatelessWidget {
  const StatusTittle(
      {super.key, required this.dbState, required this.currentUser});

  //String title = "IDMatic 3";
  final String dbState;
  final String currentUser;

  @override
  Widget build(context) {
    if (dbState.contains("Подключен")) {
      return Row(
        children: [
          const Text("IDMatic 3"),
          const Spacer(),
          Text(currentUser),
          const Spacer(),
          const Icon(
            Icons.done_outline_outlined,
            color: Colors.green,
          ),
          Text(
            dbState,
            textScaleFactor: 0.5,
            maxLines: 4,
          )
        ],
      );
    } else {
      return const Row(
        children: [
          Icon(
            Icons.disabled_by_default,
            color: Colors.red,
          )
        ],
      );
    }
  }
}
