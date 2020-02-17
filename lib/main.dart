import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'model/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bill Tracker",
      home: BillPage(),
      theme: ThemeData(
          primaryColor: Colors.orange,
          accentColor: Colors.orange,
          fontFamily: "font1",
          textTheme: TextTheme(
            title: TextStyle(
                fontFamily: "font2", fontSize: 18, fontWeight: FontWeight.bold),
          ),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(
                      fontFamily: "font1",
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  List<Transaction> _userTranscation = [
//    Transaction(title: "Glass", amount: 100.00, date: DateTime.now()),
//    Transaction(title: "Shirts", amount: 150.00, date: DateTime.now()),
//    Transaction(title: "Shoes", amount: 500.00, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTranscation.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  String title;
  double amount;
  bool _showChart = false;

  void _addProduct(String title, double amount, DateTime date2) {
    final newTrans = new Transaction(
      title: title,
      amount: amount,
      date: date2,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTranscation.add(newTrans);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTranscation.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _showAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewTransaction(_addProduct);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Track your bills !"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onTap: () => _showAddTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text("Track your bills !"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () => _showAddTransaction(context),
              ),
            ],
          );

    final txListWidget = Container(
        height: (mediaQuery.size.height * 0.7) -
            appBar.preferredSize.height -
            mediaQuery.padding.top,
        child: TransactionList(_userTranscation, _deleteTransaction));

    final pageBody = SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (isLandScape) //sdk updated in pubspec.yaml as 2.2.3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Show Chart",
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Theme.of(context).accentColor,
                      fontFamily: "font1",
                      fontSize: 25),
                ),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
          if (!isLandScape)
            Container(
              height: (mediaQuery.size.height * 0.4) -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top,
              child: Chart(_recentTransactions),
            ),
          if (!isLandScape) txListWidget,
          if (isLandScape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height * 0.7) -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top,
                    child: Chart(_recentTransactions))
                : txListWidget,
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showAddTransaction(context),
                  ),
          );
  }
}
