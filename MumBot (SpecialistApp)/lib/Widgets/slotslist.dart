import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parenting_specialist/models/addslotmodel.dart';
import 'package:http/http.dart' as http;

import '../models/slot.dart';

class SlotsList extends StatefulWidget {
  final List<Slot> _slots;
  final Function _deleteTx;
  SlotsList(this._slots, this._deleteTx);

  @override
  _SlotsListState createState() => _SlotsListState();
}

List _data;
int _freeDay;
String _slotDate;
String _slotStartTime;

class _SlotsListState extends State<SlotsList> {
  //Future<AddSlotModel> _fetchSlots;

  @override
  void initState() {
    super.initState();
    fetchSlotsData();
  }

  Future<AddSlotModel> fetchSlotsData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/apis/api/question/'));

    if (response.statusCode == 200) {
      setState(() {
        var _resBody = json.decode(response.body);
        _data = _resBody;
      });
    } else {
      print('404');
      throw Exception('Failed to load question');
    }
  }

  Future<AddSlotModel> deleteSlot(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/apis/api/slot/delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('slot Deleted');
      return AddSlotModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete Slot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget._slots.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No Slots Yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.43,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: _data == null ? 0 : _data.length,
            itemBuilder: (ctx, index) {
              _freeDay = _data[index]['free_day'];
              _slotDate = _data[index]['slot_date'];
              _slotStartTime = _data[index]['slot_start_time'];
              int _slotId = _data[index]['id'];
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
                            DateFormat.E().format(
                              DateTime.parse(_slotDate),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      DateFormat.yMMMd().format(DateTime.parse(_slotDate)),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.Hm().format(
                        DateTime.parse(_slotStartTime),
                      ),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                  deleteSlot(_slotId);
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
