import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parenting_specialist/Screens/login_screen.dart';
import 'package:parenting_specialist/models/specialist.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../models/slot.dart';
import '../VideoChat/call.dart';

class AppointmentsList extends StatefulWidget {
  static const routeName = '/videolist-screen';
  final List<Slot> transactions;
  final Function deleteTx;
  AppointmentsList(this.transactions, this.deleteTx);

  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

List _data;
int _freeDay;
String _slotDate;
String _slotStartTime;

class _AppointmentsListState extends State<AppointmentsList> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  // ignore: unused_field
  bool _validateError = false;
  // ignore: unused_field
  ClientRole _role = ClientRole.Broadcaster;
  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }
  // Future<AddSlotModel> _fetchSlots;

  @override
  void initState() {
    super.initState();
    fetchParentAppointments(specialistLoginData['id']);
  }

  Future<Specialist> fetchParentAppointments(int id) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/apis/api/specialistappointments/$id'));

    if (response.statusCode == 200) {
      setState(() {
        var _resBody = json.decode(response.body);
        _data = _resBody;
      });
    } else {
      print('404');
      throw Exception('Failed to Specialist Appointments');
    }
  }

  Future<Specialist> deleteParentAppointments(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/apis/api/slot/delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('slot Deleted');
      return Specialist.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete Slot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No Sessions Yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: _data == null ? 0 : _data.length,
            itemBuilder: (ctx, index) {
              _freeDay = _data[index]['free_day'];
              _slotDate = _data[index]['slot_date'];
              _slotStartTime = _data[index]['slot_start_time'];
              int _slotId = _data[index]['id'];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            DateFormat.E().format(
                              DateTime.parse(_slotDate),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      DateFormat.yMMMd().format(DateTime.parse(_slotDate)),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.Hm().format(
                        DateTime.parse(_slotStartTime),
                      ),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: Container(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                // widget.deleteTx(widget.slots[index].id);
                                setState(() {
                                  // deleteSlot(_slotId);
                                });
                              }),
                        ],
                      ),
                    )),
              );
            },
          );
  }

  Future<void> onJoin() async {
    // update input validation
    // setState(() {
    //   _channelController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });
    // if (_channelController.text.isNotEmpty) {
    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: 'MumBot',
          role: ClientRole.Broadcaster,
        ),
      ),
    );
    // }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
