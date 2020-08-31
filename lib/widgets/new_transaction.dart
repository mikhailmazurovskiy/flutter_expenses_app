import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptive_button.dart';

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
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 25),
              child: Row(
                children: [
                  Text(
                    'New Transaction',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Platform.isIOS
                ? Column(
                    children: [
                      CupertinoTextField(
                        placeholder: 'Title',
                        controller: _titleController,
                        onSubmitted: (_) => _submitData(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoTextField(
                        placeholder: 'Amount',
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        onSubmitted: (_) => _submitData(),
                      )
                    ],
                  )
                : Column(
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
                    ],
                  ),
            Container(
              height: 70,
              child: Row(
                children: [
                  AdaptiveButton('Choose date', _displayDatePicker),
                  Expanded(
                    child: Text(
                      _enteredDate == null
                          ? 'No date chosen'
                          : 'Picked date: ${DateFormat.yMMMd().format(_enteredDate)}',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.95,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Add transaction',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
