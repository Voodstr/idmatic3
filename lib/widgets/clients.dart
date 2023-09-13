import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postgres/postgres.dart';
import 'package:idmatic3/data.dart' as pgdata;

class ClientsWidget extends StatefulWidget {
  const ClientsWidget({super.key, required this.connection});

  final PostgreSQLConnection connection;

  @override
  State<ClientsWidget> createState() => _ClientsWidgetState();
}

class _ClientsWidgetState extends State<ClientsWidget> {
  var _sortIndex = 0;
  var _asc = false;
  var acc = pgdata.Account();
  var _isLoading = true;
  final List<pgdata.Account> _oldClients = [];
  List<pgdata.Account> _clients = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var myColumns = [
      DataColumn(
          label: const Expanded(
              child: Text(
            'IP адрес',
            textAlign: TextAlign.center,
          )),
          onSort: (ind, dir) {
            _sort(ind, dir);
          }),
      DataColumn(
          label: const Expanded(
              child: Text(
            'Порт',
            textAlign: TextAlign.center,
          )),
          onSort: (ind, dir) {
            _sort(ind, dir);
          }),
      DataColumn(
          label: const Expanded(
              child: Text(
            'Пользователь',
            textAlign: TextAlign.center,
          )),
          onSort: (ind, dir) {
            _sort(ind, dir);
          }),
      DataColumn(
          label: const Expanded(
              child: Text(
            'Пароль',
            textAlign: TextAlign.center,
          )),
          onSort: (ind, dir) {
            _sort(ind, dir);
          }),
      DataColumn(
          label: const Expanded(
              child: Text(
            'Время',
            textAlign: TextAlign.center,
          )),
          onSort: (ind, dir) {
            _sort(ind, dir);
          }),
      DataColumn(
          label: const Expanded(
              child: Text(
            'Почта',
            textAlign: TextAlign.center,
          )),
          onSort: (ind, dir) {
            _sort(ind, dir);
          }),
      const DataColumn(
        label: Expanded(
            child: Text(
          'Фото',
          textAlign: TextAlign.center,
        )),
      ),
      const DataColumn(
        label: Expanded(
            child: Text(
          'Активно',
          textAlign: TextAlign.center,
        )),
      ),
      DataColumn(
          label: const Expanded(
              child: Text(
            'Описание',
            textAlign: TextAlign.center,
          )),
          onSort: (ind, dir) {
            _sort(ind, dir);
          }),
    ];
    var myRows = _clients.map((client) {
      var ipController = TextEditingController(text: client.ip);
      var portController = TextEditingController(text: client.port.toString());
      var userController = TextEditingController(text: client.username);
      var pwdController = TextEditingController(text: client.password);
      var timeoutController =
          TextEditingController(text: client.connectionTimeout.toString());
      var emailController = TextEditingController(text: client.email);
      var nameController = TextEditingController(text: client.name);
      return DataRow(
          cells: [
            DataCell(TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]')),
              ],
              controller: ipController,
              onChanged: (text) => {
                _clients
                    .elementAt(_clients
                        .indexWhere((element) => element.id == client.id))
                    .ip = text
              },
            )),
            DataCell(TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: portController,
              onChanged: (text) => {
                _clients
                    .elementAt(_clients
                        .indexWhere((element) => element.id == client.id))
                    .port = int.parse(text)
              },
            )),
            DataCell(TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              controller: userController,
              onChanged: (text) => {
                _clients
                    .elementAt(_clients
                        .indexWhere((element) => element.id == client.id))
                    .username = text
              },
            )),
            DataCell(TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              controller: pwdController,
              onChanged: (text) => {
                _clients
                    .elementAt(_clients
                        .indexWhere((element) => element.id == client.id))
                    .password = text
              },
            )),
            DataCell(TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: timeoutController,
              onChanged: (text) => {
                _clients
                    .elementAt(_clients
                        .indexWhere((element) => element.id == client.id))
                    .connectionTimeout = int.parse(text)
              },
            )),
            DataCell(TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              controller: emailController,
              onChanged: (text) => {
                _clients
                    .elementAt(_clients
                        .indexWhere((element) => element.id == client.id))
                    .email = text
              },
            )),
            DataCell(Checkbox(
              value: client.sendPhoto,
              onChanged: (bool? value) {
                checkSendPhoto(client.id, value!);
              },
            )),
            DataCell(Checkbox(
              value: client.active,
              onChanged: (bool? value) {
                checkActive(client.id, value!);
              },
            )),
            DataCell(TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              controller: nameController,
              onChanged: (text) => {
                _clients
                    .elementAt(_clients
                        .indexWhere((element) => element.id == client.id))
                    .name = text
              },
            )),
          ],
          selected: _clients
              .elementAt(
                  _clients.indexWhere((element) => element.id == client.id))
              .selected,
          onSelectChanged: (sel) => selectClient(client.id, sel!));
    }).toList();
    if (_isLoading) {
      return const CircularProgressIndicator();
    } else {
      return Scaffold(
        persistentFooterAlignment: AlignmentDirectional.topCenter,
        persistentFooterButtons: [
          TextButton(
              onPressed: () => addClient(context),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.grey.shade200)),
              child: const Text(
                "Добавить",
              )),
          TextButton(
              onPressed: () => removeClients(context),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade200)),
              child: const Text(
                "Удалить",
              )),
          TextButton(
              onPressed: () => saveClients(context),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.green.shade200)),
              child: const Text(
                "Сохранить",
              ))
        ],
        appBar: AppBar(
          title: const Text("Внешние клиенты"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: DataTable(
              columnSpacing: 10,
              columns: myColumns,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                  width: 10,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              rows: myRows,
              sortColumnIndex: _sortIndex,
              showBottomBorder: true,
              sortAscending: _asc,
            ),
          ),
        ),
      );
      /*
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () => addClient(context),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.grey.shade200)),
                child: const Text(
                  "Добавить",
                  textScaleFactor: 2.0,
                )),
            TextButton(
                onPressed: () => removeClients(context),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.red.shade200)),
                child: const Text(
                  "Удалить",
                  textScaleFactor: 2.0,
                )),
            TextButton(
                onPressed: () => saveClients(context),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.green.shade200)),
                child: const Text(
                  "Сохранить",
                  textScaleFactor: 2.0,
                ))
          ],
        )
      ]);

       */
    }
  }

  void getData() async {
    setState(() => _isLoading = true);
    List<List<dynamic>> results =
        await widget.connection.query("SELECT * FROM taccount");
    _oldClients.clear();
    for (final row in results) {
      _oldClients.add(
        pgdata.Account(
            ip: row[0],
            port: row[1],
            username: row[2],
            password: row[3],
            connectionTimeout: row[4],
            email: row[5],
            sendPhoto: row[6],
            active: row[7],
            id: row[8],
            name: row[9]),
      );
    }
    _clients = _oldClients;
    setState(() => _isLoading = false);
  }

  void _sort(int index, bool direction) {
    setState(() {
      _asc = direction;
      _sortIndex = index;
      switch (_sortIndex) {
        case 0:
          {
            _clients.sort((a, b) => a.ip.compareTo(b.ip));
          }
        case 1:
          {
            _clients.sort((a, b) => a.username.compareTo(b.username));
          }
        case 2:
          {
            _clients.sort((a, b) => a.password.compareTo(b.password));
          }
        case 3:
          {
            _clients.sort(
                (a, b) => a.connectionTimeout.compareTo(b.connectionTimeout));
          }
        case 6:
          {
            _clients.sort((a, b) => a.name.compareTo(b.name));
          }
        default:
          {
            _clients.sort((a, b) => a.id.compareTo(b.id));
          }
      }
      if (!_asc) {
        _clients = _clients.reversed.toList();
      }
    });
  }

  void checkSendPhoto(int id, bool check) {
    setState(() {
      _clients
          .elementAt(_clients.indexWhere((element) => element.id == id))
          .sendPhoto = check;
    });
  }

  void checkActive(int id, bool check) {
    setState(() {
      _clients
          .elementAt(_clients.indexWhere((element) => element.id == id))
          .active = check;
    });
  }

  void selectClient(int id, bool sel) {
    setState(() {
      _clients
          .elementAt(_clients.indexWhere((element) => element.id == id))
          .selected = sel;
    });
  }

  Future<bool> approveDialog(BuildContext context) async {
    bool result = false;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Подтвердите'),
            content: const Text('Вы действительно хотите удалить?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    result = true;
                    Navigator.of(context).pop();
                    // Remove the box
                    // Close the dialog
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    result = false;
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
    return result;
  }

  Future<void> removeClients(BuildContext context) async {
    if (_clients.where((element) => element.selected).isNotEmpty) {
      await approveDialog(context)
          ? {
              _clients
                  .where((element) => element.selected)
                  .forEach((element) async {
                await widget.connection.query(
                    "DELETE FROM taccount where id = @id",
                    substitutionValues: {"id": element.id});
              })
            }
          : {};
      getData();
    }
  }

  Future<void> saveClients(BuildContext context) async {
    await approveDialog(context)
        ? {
            for (var element in _clients)
              {
                await widget.connection.query(
                    "UPDATE taccount SET "
                    "ip = @ip,"
                    "port = @port,"
                    "username = @username,"
                    "password = @password,"
                    "connect_timeout = @connect_timeout,"
                    "email_address = @email_address,"
                    "is_send_photo = @is_send_photo,"
                    "active = @active,"
                    "name = @name"
                    " where id = @id",
                    substitutionValues: {
                      "id": element.id,
                      "ip": element.ip,
                      "port": element.port,
                      "username": element.username,
                      "password": element.password,
                      "connect_timeout": element.connectionTimeout,
                      "email_address": element.email,
                      "is_send_photo": element.sendPhoto,
                      "active": element.active,
                      "name": element.name,
                    })
              }
          }
        : {};
    getData();
  }

  Future<void> addClient(BuildContext context) async {
    await widget.connection.query(
        "INSERT INTO taccount (ip,email_address,username,password,name) VALUES ('127.0.0.1','email@email','','','')");
    getData();
  }
}
