import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/login_screen.dart';
import 'package:parenting_specialist/models/addslotmodel.dart';
import 'package:http/http.dart' as http;

int slotId;

class SlotsList extends StatefulWidget {
  @override
  _SlotsListState createState() => _SlotsListState();
}

List _data;
String _freeDay;
String _slotDate;
String _slotStartTime;
int slotId2;

class _SlotsListState extends State<SlotsList> {
  @override
  void initState() {
    super.initState();
    fetchSlots(specialistLoginData['id']);
  }

  Future<AddSlotModel> fetchSlots(int id) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/apis/api/slot/$id/'));

    if (response.statusCode == 200) {
      setState(() {
        var _resBody = json.decode(response.body);
        _data = _resBody;
      });
    } else {
      print('404');
      throw Exception('Failed to load Slots');
    }
  }

  Future<AddSlotModel> deleteSlot(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/apis/api/slot/delete/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // if (response.statusCode == 200) {
    //   print('slot Deleted');
    //   return AddSlotModel.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception(response.statusCode);
    // }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      fetchSlots(specialistLoginData['id']);
    });
    // return widget._slots.isEmpty
    //     ? LayoutBuilder(builder: (ctx, constraints) {
    //         return Column(
    //           children: [
    //             Text(
    //               'No Slots Yet!',
    //               style: Theme.of(context).textTheme.headline6,
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Container(
    //               height: constraints.maxHeight * 0.43,
    //               child: Image.asset(
    //                 'assets/images/waiting.png',
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ],
    //         );
    //       })
    //     :
    return ListView.builder(
      itemCount: _data == null ? 0 : _data.length,
      itemBuilder: (ctx, index) {
        _freeDay = _data[index]['free_day'];
        _slotDate = _data[index]['slot_date'];
        _slotStartTime = _data[index]['slot_start_time'];
        slotId = _data[index]['id'];
        int slotId1 = slotId;
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
                      _freeDay,
                      //  ),
                    ),
                  ),
                ),
              ),
              title: Text(
                //DateFormat.yMMMd().format(DateTime.parse(_slotDate)),
                _slotDate,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                // DateFormat.Hm().format(
                //   DateTime.parse(_slotStartTime),
                _slotStartTime,
                //),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          // widget.deleteTx(widget.slots[index].id);
                          setState(() {
                            slotId2 = slotId1;
                            deleteSlot(slotId1);
                          });
                        }),
                  ],
                ),
              )),
        );
      },
    );
  }
}
