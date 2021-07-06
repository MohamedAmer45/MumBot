import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mumbot_v2/models/fetch_sessions_data.dart';
import 'package:mumbot_v2/screens/session_payment_screen.dart';
import 'package:mumbot_v2/screens/sessions_screen.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';
import 'package:mumbot_v2/widgets/LineDivider.dart';
import 'package:mumbot_v2/widgets/constants.dart';
import 'package:mumbot_v2/widgets/days.dart';
import 'package:mumbot_v2/widgets/rounded_button.dart';
import 'package:mumbot_v2/widgets/sessions_list.dart';
import 'package:http/http.dart' as http;

DateTime time = DateTime.now();
int slotId;

class BookingSessionScreen extends StatefulWidget {
  static const routeName = '/bookingsession-screen';

  @override
  _BookingSessionScreenState createState() => _BookingSessionScreenState();
}

List _data;
String _slotEndTime;
String _slotStartTime;
String freeDay = '';

class _BookingSessionScreenState extends State<BookingSessionScreen> {
  Future<FetchSessionsData> fetchDataSlots(String date) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/apis/api/slotsearch/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'daydate': date,
      }),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      setState(() {
        var _resBody = json.decode(response.body);
        _data = _resBody;
      });
    } else {
      throw Exception('Failed to load Slots');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Book Session'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  DaysButton(
                    text: DateFormat.E().format(time),
                    press: () {
                      String val = DateFormat('yyyy-MM-dd').format(time);
                      fetchDataSlots(val);
                      freeDay = DateFormat.E().format(time);
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  DaysButton(
                    text: DateFormat.E().format(time.add(Duration(days: 1))),
                    press: () {
                      String val = DateFormat('yyyy-MM-dd')
                          .format(time.add(Duration(days: 1)));
                      fetchDataSlots(val);
                      freeDay =
                          DateFormat.E().format(time.add(Duration(days: 1)));
                      // day = freeDay;
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  DaysButton(
                    text: DateFormat.E().format(time.add(Duration(days: 2))),
                    press: () {
                      String val = DateFormat('yyyy-MM-dd')
                          .format(time.add(Duration(days: 2)));
                      fetchDataSlots(val);
                      freeDay =
                          DateFormat.E().format(time.add(Duration(days: 2)));
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  DaysButton(
                    text: DateFormat.E().format(time.add(Duration(days: 3))),
                    press: () {
                      String val = DateFormat('yyyy-MM-dd')
                          .format(time.add(Duration(days: 3)));
                      fetchDataSlots(val);
                      freeDay =
                          DateFormat.E().format(time.add(Duration(days: 3)));
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  DaysButton(
                    text: DateFormat.E().format(time.add(Duration(days: 4))),
                    press: () {
                      String val = DateFormat('yyyy-MM-dd')
                          .format(time.add(Duration(days: 4)));
                      fetchDataSlots(val);
                      freeDay =
                          DateFormat.E().format(time.add(Duration(days: 4)));
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  DaysButton(
                    text: DateFormat.E().format(time.add(Duration(days: 5))),
                    press: () {
                      String val = DateFormat('yyyy-MM-dd')
                          .format(time.add(Duration(days: 5)));
                      fetchDataSlots(val);
                      freeDay =
                          DateFormat.E().format(time.add(Duration(days: 5)));
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  DaysButton(
                    text: DateFormat.E().format(time.add(Duration(days: 6))),
                    press: () {
                      String val = DateFormat('yyyy-MM-dd')
                          .format(time.add(Duration(days: 6)));
                      fetchDataSlots(val);
                      freeDay =
                          DateFormat.E().format(time.add(Duration(days: 6)));
                    },
                  ),
                ],
              ),
              width: double.infinity,
              height: 65,
            ),
            LineDivider(),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: ListView.builder(
                  itemCount: _data == null ? 0 : _data.length,
                  itemBuilder: (ctx, index) {
                    _slotEndTime = _data[index]['slot_end_time'];
                    _slotStartTime = _data[index]['slot_start_time'];

                    slotId = _data[index]['id'];
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
                                  freeDay,
                                  //  ),
                                ),
                              ),
                            ),
                          ),
                          title: Container(
                            child: Text(
                              'Start Time ${_slotStartTime.substring(0, 5)}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            width: 60,
                          ),
                          subtitle: Text(
                            // DateFormat.Hm().format(
                            //   DateTime.parse(_slotStartTime),
                            'End Time ${_slotEndTime.substring(0, 5)}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Container(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.add_circle),
                                    color: Colors.green,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              SessionPaymentScreen.routeName);
                                    }),
                              ],
                            ),
                          )),
                    );
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }
}
