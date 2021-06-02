import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:mumbot_v2/VideoChat/new_video.dart';
import 'package:mumbot_v2/VideoChat/video_list.dart';
import 'package:mumbot_v2/models/transaction.dart';
import 'package:mumbot_v2/screens/Login/components/or_divider.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';

class IndexPage extends StatefulWidget {
  static const routeName = '/video-screen';
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(DateTime chosenTime, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(), time: chosenTime, date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewVideo(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
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
            // Image.asset(
            //   "assets/MumBot3.png",
            //   height: size.height * 0.25,
            // ),
            Text(
              "Your Video Sessions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
            ),
            OrDivider(),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: VideoList(_userTransactions, _deleteTransaction)),

            // PanelCards(
            //     'Video Session 1 ',
            //     AssetImage("assets/images/Video.jpg"),
            //     '          Monday 1/6/2021  \n         1:00 PM - 2:00 PM ',
            //     'Start Session', () {
            //   onJoin();
            // }),

            // SizedBox(height: size.height * 0.35),

            RoundedButton(
              text: "Book a new Session",
              press: () {
                _startAddNewTransaction(context);
                // Navigator.of(context).pushNamed(BookSessionScreen.routeName);
              },
              // () {
              //   DatePicker.showDatePicker(context,
              //       showTitleActions: true,
              //       minTime: DateTime(2018, 3, 5),
              //       maxTime: DateTime(2019, 6, 7), onChanged: (date) {
              //     print('change $date');
              //   }, onConfirm: (date) {
              //     print('confirm $date');
              //   }, currentTime: DateTime.now(), locale: LocaleType.en);
              // },
            ),
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
