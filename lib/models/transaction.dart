import 'package:flutter/material.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime datetime;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.datetime,
  });
}
