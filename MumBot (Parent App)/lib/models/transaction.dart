import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final DateTime time;
  final DateTime date;

  Transaction({@required this.id, @required this.time, @required this.date});
}
