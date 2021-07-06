import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mumbot_v2/models/fetch_sessions_data.dart';
import 'package:mumbot_v2/screens/booking_session_screen.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';
import 'package:mumbot_v2/widgets/LineDivider.dart';
import 'package:mumbot_v2/widgets/sessions_list.dart';
import 'package:mumbot_v2/widgets/rounded_button.dart';
import 'package:http/http.dart' as http;

class SessionsScreen extends StatefulWidget {
  static const routeName = '/appointment-screen';
  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

List _data;

class _SessionsScreenState extends State<SessionsScreen> {
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
        title: Text('Video Sessions'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Text(
              "Your Video Sessions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
            ),
            LineDivider(),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: SessionsList()),
            RoundedButton(
              text: "Book Video Session",
              press: () {
                String val = DateFormat('yyyy-MM-dd').format(time);
                fetchDataSlots(val);
                Navigator.of(context)
                    .pushReplacementNamed(BookingSessionScreen.routeName);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }
}
