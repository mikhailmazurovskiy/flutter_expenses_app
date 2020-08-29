import 'package:flutter/material.dart';
import 'package:flutter_expenses_app/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import 'package:uuid/uuid.dart';
import './widgets/chart.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.deepOrange,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: '1',
    //   title: 'Shoes',
    //   amount: 55.55,
    //   datetime: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Toesk',
    //   amount: 9.55,
    //   datetime: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.datetime.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _appendTransactions(String title, double amount, DateTime date) {
    Transaction newTx = Transaction(
        id: Uuid().v1().toString(),
        title: title,
        amount: amount,
        datetime: date);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String uuid) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == uuid);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_appendTransactions),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Expenses app',
        style: TextStyle(
          fontFamily: 'OpenSans',
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    final heightAvailableForWidgets = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: heightAvailableForWidgets * 0.3,
              child: Chart(_userTransactions),
            ),
            Container(
              height: heightAvailableForWidgets * 0.7,
              child: TransactionList(_recentTransactions, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
