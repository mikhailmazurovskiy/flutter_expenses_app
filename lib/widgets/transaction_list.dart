import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_card.dart';

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
              return TransactionCard(
                key: ValueKey(_transactionsToBuild[txIndex].id),
                transaction: _transactionsToBuild[txIndex],
                deleteTxHandler: _deleteTxHandler,
              );
            },
            itemCount: _transactionsToBuild.length,
          );
  }
}
