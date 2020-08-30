import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function appendTransactions;

  NewTransaction(this.appendTransactions);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _enteredDate;

  void _submitData() {
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);
    final DateTime enteredDateAgain = _enteredDate;

    if (enteredTitle.isEmpty || enteredAmount < 0 || _enteredDate == null) {
      return;
    }

    widget.appendTransactions(enteredTitle, enteredAmount, enteredDateAgain);

    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _enteredDate = pickedDate;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _enteredDate == null
                            ? 'No date chosen'
                            : 'Picked date: ${DateFormat.yMMMd().format(_enteredDate)}',
                      ),
                    ),
                    AdaptiveButton('Choose date', _displayDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add transaction'),
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          )),
    );
  }
}
