import 'package:flutter/cupertino.dart';
import 'package:postgres/postgres.dart';

export 'privileges.dart';
export 'person.dart';
export 'holidays.dart';
export 'equipment.dart';
export 'accounting.dart';
export 'accesslevel.dart';
export 'journal.dart';
export 'clients.dart';
export 'login-dialog.dart';
export 'status-title.dart';

abstract class PGStatefulWidget extends StatefulWidget{
   const PGStatefulWidget({super.key,required this.connection});
   final PostgreSQLConnection? connection;

}

