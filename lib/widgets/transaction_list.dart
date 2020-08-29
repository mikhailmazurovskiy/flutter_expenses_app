import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactionsToBuild;
  final Function _deleteTxHandler;

  TransactionList(this._transactionsToBuild, this._deleteTxHandler);

  @override
  Widget build(BuildContext context) {
    return _transactionsToBuild.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions added yet',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
                height: 200,
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, txIndex) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text(
                              '\$${_transactionsToBuild[txIndex].amount}')),
                    ),
                  ),
                  title: Text(
                    _transactionsToBuild[txIndex].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd()
                        .format(_transactionsToBuild[txIndex].datetime),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () =>
                        _deleteTxHandler(_transactionsToBuild[txIndex].id),
                  ),
                ),
              );
            },
            itemCount: _transactionsToBuild.length,
          );
  }
}
