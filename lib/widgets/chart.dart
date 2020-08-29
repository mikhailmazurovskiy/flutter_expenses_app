import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSumForWeekday = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].datetime.day == weekDay.day &&
            recentTransactions[i].datetime.month == weekDay.month &&
            recentTransactions[i].datetime.year == weekDay.year) {
          totalSumForWeekday += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSumForWeekday,
      };
    }).reversed.toList();
  }

  double get weekTotalSum {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  weekTotalSum == 0.0
                      ? 0.0
                      : (data['amount'] as double) / weekTotalSum),
            );
          }).toList(),
        ),
      ),
    );
  }
}
