import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/user_panel_screen.dart';
import 'package:parenting_specialist/Widgets/addslot.dart';
import 'package:parenting_specialist/Widgets/LineDivider.dart';
import 'package:parenting_specialist/Widgets/rounded_button.dart';
import 'package:parenting_specialist/Widgets/slotslist.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule-screen';

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  void _startAddNewSlot(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddSlot(),
            behavior: HitTestBehavior.opaque,
          );
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
                child: SlotsList()),
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
