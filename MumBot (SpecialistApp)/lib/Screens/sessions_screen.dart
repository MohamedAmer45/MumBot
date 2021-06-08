import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/user_panel_screen.dart';
import 'package:parenting_specialist/VideoChat/call.dart';
import 'package:parenting_specialist/Widgets/sessionslist.dart';
import 'package:parenting_specialist/models/slot.dart';
import 'package:parenting_specialist/widgets/LineDivider.dart';
import 'package:parenting_specialist/widgets/rounded_button.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Widgets/addslot.dart';

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
        //title: Text('Video Sessions'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            // Image.asset(
            //   "assets/MumBot3.png",
            //   height: size.height * 0.25,
            // ),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }
}
