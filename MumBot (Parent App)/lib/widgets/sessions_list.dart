import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:mumbot_v2/api/parent_api.dart';
import 'package:mumbot_v2/models/addsession.dart';
import 'package:mumbot_v2/models/fetch_sessions_data.dart';
import 'package:mumbot_v2/models/video_session.dart';
import 'package:mumbot_v2/screens/booking_session_screen.dart';
import 'package:mumbot_v2/screens/login_screen.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../VideoChat/call.dart';

Map<String, dynamic> sessionSlotId;

//String _date;

class SessionsList extends StatefulWidget {
  // String date;

  @override
  _SessionsListState createState() => _SessionsListState();
}

List _data;
String _slotEndTime;
String _slotStartTime;

class _SessionsListState extends State<SessionsList> {
  @override
  void initState() {
    super.initState();

    fetchSessionId();
    fetchSessions(sessionSlotIdd);
  }

  int sessionSlotIdd = sessionSlotId['video_slot'];

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
  Future<FetchSessionsData> fetchSessions(int id) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/apis/api/slot/$id/'));

    if (response.statusCode == 200) {
      setState(() {
        var _resBody = json.decode(response.body);
        _data = _resBody;
      });
    } else {
      print('404');
      throw Exception('Failed to load Slots');
    }
  }

  // ignore: missing_return
  Future<AddSession> fetchSessionId() async {
    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:8000/apis/api/parentappointments/${parentLoginData['id']}/'),
    );
    if (response.statusCode == 200) {
      sessionSlotId = jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load sessions');
    }
  }

  Future<VideoSession> deleteSession(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/apis/api/appointment/delete/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      fetchSessionId();
      fetchSessions(sessionSlotIdd);
    });
    // return widget._slots.isEmpty
    //     ? LayoutBuilder(builder: (ctx, constraints) {
    //         return Column(
    //           children: [
    //             Text(
    //               'No Slots Yet!',
    //               style: Theme.of(context).textTheme.headline6,
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Container(
    //               height: constraints.maxHeight * 0.43,
    //               child: Image.asset(
    //                 'assets/images/waiting.png',
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ],
    //         );
    //       })
    //     :
    return ListView.builder(
      itemCount: _data == null ? 0 : _data.length,
      itemBuilder: (ctx, index) {
        _slotEndTime = _data[index]['slot_end_time'];
        _slotStartTime = _data[index]['slot_start_time'];
        int _sessionId = _data[index]['id'];
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
                      // DateFormat.E().format(
                      //   DateTime.parse(_freeDay),
                      _slotStartTime,
                      //  ),
                    ),
                  ),
                ),
              ),
              title: Text(
                //DateFormat.yMMMd().format(DateTime.parse(_slotDate)),
                _slotEndTime,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                // DateFormat.Hm().format(
                //   DateTime.parse(_slotStartTime),
                _slotStartTime,
                //),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(Icons.play_arrow),
                        color: Colors.green,
                        onPressed: () {
                          onJoin();
                        }),
                    IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          // widget.deleteTx(widget.slots[index].id);
                          setState(() {
                            deleteSession(_sessionId);
                            ParentAPI().updateSlotsListzero(slotId);
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
