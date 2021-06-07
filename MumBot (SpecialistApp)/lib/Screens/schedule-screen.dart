import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/user_panel_screen.dart';
import 'package:parenting_specialist/Widgets/addslot.dart';
import 'package:parenting_specialist/Widgets/LineDivider.dart';
import 'package:parenting_specialist/Widgets/rounded_button.dart';
import 'package:parenting_specialist/Widgets/slotslist.dart';
import 'package:parenting_specialist/models/slot.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule-screen';

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<Slot> _specialistSlots = [];
  // ignore: unused_element
  List<Slot> get _recentSlots {
    return _specialistSlots.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewSlot(DateTime chosenTime, DateTime chosenDate) {
    final _newTx =
        Slot(id: DateTime.now().toString(), time: chosenTime, date: chosenDate);

    setState(() {
      _specialistSlots.add(_newTx);
    });
  }

  void _startAddNewSlot(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddSlot(_addNewSlot),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteSlot(String id) {
    setState(() {
      _specialistSlots.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Text(
              "Your Slots",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
            ),
            LineDivider(),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: SlotsList(_specialistSlots, _deleteSlot)),
            RoundedButton(
              text: "Add a new slot",
              press: () {
                _startAddNewSlot(context);
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
