// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mumbot_v2/VideoChat/call.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../models/transaction.dart';

// class VideoList extends StatefulWidget {
//   final List<Transaction> transactions;
//   final Function deleteTx;
//   VideoList(this.transactions, this.deleteTx);

//   @override
//   _VideoListState createState() => _VideoListState();
// }

// class _VideoListState extends State<VideoList> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.transactions.isEmpty
//         ? LayoutBuilder(builder: (ctx, constraints) {
//             return Column(
//               children: [
//                 Text(
//                   'No Sessions Yet!',
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   height: constraints.maxHeight * 0.6,
//                   child: Image.asset(
//                     'assets/images/waiting.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             );
//           })
//         : ListView.builder(
//             itemBuilder: (ctx, index) {
//               return Card(
//                 elevation: 5,
//                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//                 child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 30,
//                       child: Container(
//                         padding: EdgeInsets.all(5),
//                         child: FittedBox(child: Text('test}')),
//                       ),
//                     ),
//                     title: Text(
//                       DateFormat.Hm().format(widget.transactions[index].time),
//                     ),
//                     subtitle: Text(
//                       DateFormat.yMMMd()
//                           .format(widget.transactions[index].date),
//                     ),
//                     trailing: Container(
//                       width: 150,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             // width: 100,
//                             child: IconButton(
//                               icon: Icon(
//                                 Icons.play_circle_fill,
//                                 color: Color(0XFF0D47A1),
//                               ),

//                               onPressed: () {
//                                 onJoin();
//                               },

//                               // style: TextStyle(fontSize: 10),
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete),
//                             color: Theme.of(context).errorColor,
//                             onPressed: () =>
//                                 widget.deleteTx(widget.transactions[index].id),
//                           ),
//                         ],
//                       ),
//                     )),
//               );
//             },
//             itemCount: widget.transactions.length,
//           );
//   }

//   Future<void> onJoin() async {
//     // update input validation
//     // setState(() {
//     //   _channelController.text.isEmpty
//     //       ? _validateError = true
//     //       : _validateError = false;
//     // });
//     // if (_channelController.text.isNotEmpty) {
//     // await for camera and mic permissions before pushing video page
//     await _handleCameraAndMic(Permission.camera);
//     await _handleCameraAndMic(Permission.microphone);
//     // push video page with given channel name
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CallPage(
//           channelName: 'Mumbot',
//           role: ClientRole.Broadcaster,
//         ),
//       ),
//     );
//     // }
//   }

//   Future<void> _handleCameraAndMic(Permission permission) async {
//     final status = await permission.request();
//     print(status);
//   }
// }
