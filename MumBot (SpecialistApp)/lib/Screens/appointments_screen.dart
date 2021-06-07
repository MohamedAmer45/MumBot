import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/user_panel_screen.dart';
import 'package:parenting_specialist/VideoChat/call.dart';
import 'package:parenting_specialist/Widgets/appointmentslist.dart';
import 'package:parenting_specialist/models/slot.dart';
import 'package:parenting_specialist/widgets/LineDivider.dart';
import 'package:parenting_specialist/widgets/rounded_button.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Widgets/addslot.dart';

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appointment-screen';
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // /// create a channelController to retrieve text value
  // final _channelController = TextEditingController();

  // /// if channel textField is validated to have error
  // // ignore: unused_field
  // bool _validateError = false;
  // // ignore: unused_field
  // ClientRole _role = ClientRole.Broadcaster;
  // @override
  // void dispose() {
  //   // dispose input controller
  //   _channelController.dispose();
  //   super.dispose();
  // }

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
            // Container(
            //     height: (MediaQuery.of(context).size.height -
            //             appBar.preferredSize.height -
            //             MediaQuery.of(context).padding.top) *
            //         0.7,
            //     child: AppointmentsList(
            //       _userTransactions,
            //       _deleteTransaction,
            //     )),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }

  // Future<void> onJoin() async {
  //   // update input validation
  //   // setState(() {
  //   //   _channelController.text.isEmpty
  //   //       ? _validateError = true
  //   //       : _validateError = false;
  //   // });
  //   // if (_channelController.text.isNotEmpty) {
  //   // await for camera and mic permissions before pushing video page
  //   await _handleCameraAndMic(Permission.camera);
  //   await _handleCameraAndMic(Permission.microphone);
  //   // push video page with given channel name
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CallPage(
  //         channelName: 'Mumbot',
  //         role: ClientRole.Broadcaster,
  //       ),
  //     ),
  //   );
  //   // }
  // }

  // Future<void> _handleCameraAndMic(Permission permission) async {
  //   final status = await permission.request();
  //   print(status);
  // }
}
