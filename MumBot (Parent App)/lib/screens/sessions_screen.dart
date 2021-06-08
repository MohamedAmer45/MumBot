import 'package:flutter/material.dart';
import 'package:mumbot_v2/screens/booking_session_screen.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';
import 'package:mumbot_v2/widgets/LineDivider.dart';
import 'package:mumbot_v2/widgets/sessions_list.dart';
import 'package:mumbot_v2/widgets/rounded_button.dart';

class SessionsScreen extends StatefulWidget {
  static const routeName = '/appointment-screen';
  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
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
                Navigator.of(context).pushNamed(BookingSessionScreen.routeName);
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
