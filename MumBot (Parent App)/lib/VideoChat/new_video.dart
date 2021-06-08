// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:mumbot_v2/screens/book_session_screen.dart';

// class NewVideo extends StatefulWidget {
//   final Function addTx;

//   NewVideo(this.addTx);

//   @override
//   _NewTransactionState createState() => _NewTransactionState();
// }

// class _NewTransactionState extends State<NewVideo> {
//   DateTime _selectedDate;
//   DateTime _selectedTime;

//   void _submitData() {
//     if (_selectedDate == null || _selectedTime == null) {
//       return;
//     }
//     // else {
//     //   Navigator.of(context).pushNamed(BookSessionScreen.routeName);
//     // }
//     Navigator.of(context).pop();
//     Navigator.of(context).pushNamed(BookSessionScreen.routeName);

//     widget.addTx(_selectedDate, _selectedTime);
//     //print(DateFormat.Hm().format(_selectedTime));
//     //print(DateFormat.H().format(_selectedTime));
//   }

//   void _presentDatePicker() {
//     // showDatePicker(
//     //         context: context,
//     //         initialDate: DateTime.now(),
//     //         firstDate: DateTime(2021),
//     //         lastDate: DateTime.now())
//     DatePicker.showDatePicker(context,
//             showTitleActions: true,
//             minTime: DateTime.now(),
//             maxTime: DateTime(2025, 6, 7), onChanged: (date) {
//       print('change $date');
//     }, onConfirm: (date) {
//       print('confirm $date');
//     }, currentTime: DateTime.now(), locale: LocaleType.en)
//         .then((pickedate) {
//       if (pickedate == null) {
//         return;
//       }
//       setState(() {
//         _selectedDate = pickedate;
//       });
//     });
//   }

//   void _presentTimePicker() {
//     DatePicker.showTimePicker(context,
//             showTitleActions: true,
//             showSecondsColumn: false, onChanged: (time) {
//       print('change $time');
//     }, onConfirm: (time) {
//       print('confirm $time');
//     }, currentTime: DateTime.now(), locale: LocaleType.en)
//         .then((pickedTime) {
//       if (pickedTime == null) {
//         return;
//       }
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Card(
//         elevation: 5,
//         child: Container(
//           padding: EdgeInsets.only(
//               top: 10,
//               left: 10,
//               right: 10,
//               bottom: MediaQuery.of(context).viewInsets.bottom + 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               // TextField(
//               //   decoration: InputDecoration(labelText: 'Title'),
//               //   controller: _titleController,
//               //   onSubmitted: (_) => _submitData(),
//               //   // onChanged: (val) {
//               //   //   titleInput = val;
//               //   // },
//               // ),
//               // TextField(
//               //   decoration: InputDecoration(labelText: 'Amount'),
//               //   controller: _amountController,
//               //   keyboardType: TextInputType.number,
//               //   onSubmitted: (_) => _submitData(),
//               //   // onChanged: (val) {
//               //   //   amountInput = val;
//               //   // },
//               // ),
//               Container(
//                 height: 70,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(_selectedDate == null
//                           ? 'No date chosen'
//                           : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}'),
//                     ),
//                     // ignore: deprecated_member_use
//                     FlatButton(
//                       onPressed: () {
//                         _presentDatePicker();
//                       },
//                       child: Text('Choose date'),
//                     ),
//                   ],
//                 ),
//               ),

//               Container(
//                 height: 70,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(_selectedTime == null
//                           ? 'No Time'
//                           : 'Picked Hour : ${DateFormat.H().format(_selectedTime)}'),
//                     ),
//                     // ignore: deprecated_member_use
//                     FlatButton(
//                       onPressed: () {
//                         _presentTimePicker();
//                       },
//                       child: Text('Choose Time'),
//                     ),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: _submitData,
//                 child: Text(
//                   'Proceed to Payment',
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
