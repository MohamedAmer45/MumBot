import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:parenting_specialist/Screens/login_screen.dart';
import 'package:parenting_specialist/api/specialist_api.dart';

class AddSlot extends StatefulWidget {
  @override
  _AddSlotState createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {
  int _specialistId = specialistLoginData['id'];
  String _freeDay;
  String _slotDate;
  int _slotStartTimeIntger;
  String _slotStartTime;
  String _slotEndTime;

  DateTime _selectedDate;
  DateTime _selectedTime;

  void _submitData() {
    if (_selectedDate == null || _selectedTime == null) {
      return;
    }
    Navigator.of(context).pop();

    //widget._addTx(_selectedDate, _selectedTime);
    setState(() {
      SpecialistAPI().addSlot(_specialistId, _freeDay, _slotDate,
          _slotStartTimeIntger, _slotStartTime, _slotEndTime);
      print(_specialistId);
      print(_freeDay);
      print(_slotDate);
      print(_slotStartTimeIntger);
      print(_slotStartTime);
      print(_slotEndTime);
    });
  }

  void _presentDatePicker() {
    DateTime _currentTime = DateTime.now();
    DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: _currentTime,
            maxTime: DateTime(
                _currentTime.year, _currentTime.month, _currentTime.day + 6),
            currentTime: DateTime.now(),
            locale: LocaleType.en)
        .then((_pickedate) {
      if (_pickedate == null) {
        return;
      }
      setState(() {
        _selectedDate = _pickedate;
        _freeDay = DateFormat.EEEE().format(_pickedate);
        _slotDate = DateFormat('yyyy-MM-dd').format(_pickedate);
      });
    });
  }

  void _presentTimePicker() {
    DateTime _startTime;

    DatePicker.showTimePicker(context,
            showTitleActions: true,
            showSecondsColumn: false,
            currentTime: DateTime.now(),
            locale: LocaleType.en)
        .then((_pickedTime) {
      if (_pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = _pickedTime;
        _slotStartTimeIntger = int.parse(DateFormat('hh').format(_pickedTime));
        _slotStartTime = DateFormat.Hm().format(_pickedTime);
        _startTime = _pickedTime.add(Duration(hours: 1));
        _slotEndTime = DateFormat.Hm().format(_startTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen'
                          : 'Picked Date : ${DateFormat('dd-MM-yyyy').format(_selectedDate)}'),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: Text('Choose date'),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedTime == null
                          ? 'No Time'
                          : 'Picked Hour : ${DateFormat.Hm().format(_selectedTime)}'),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        _presentTimePicker();
                      },
                      child: Text('Choose Time'),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  'Add slot',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
