import 'package:bill_tracker_2/model/transaction.dart';
import 'package:bill_tracker_2/widgets/chart.dart';
import 'package:bill_tracker_2/widgets/new_transaction.dart';
import 'package:bill_tracker_2/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

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
        textTheme: TextTheme(title: TextStyle(fontFamily: "font2", fontSize: 18, fontWeight: FontWeight.bold),),
        appBarTheme: AppBarTheme(textTheme: TextTheme(title: TextStyle(fontFamily: "font1", fontSize: 20, fontWeight: FontWeight.bold)))
      ),
    );
  }
}

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  List<Transaction> _userTranscation = [
    Transaction(title: "Glass", amount: 100.00, date: DateTime.now()),
    Transaction(title: "Shirts", amount: 150.00, date: DateTime.now()),
    Transaction(title: "Shoes", amount: 500.00, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions{
    return _userTranscation.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }

  String title;
  double amount;

  void _addProduct(String title, double amount) {
    final newTrans =
        new Transaction(title: title, amount: amount, date: DateTime.now());
    setState(() {
      _userTranscation.add(newTrans);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Tracker"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _showAddTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart( _recentTransactions),
            TransactionList(_userTranscation),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransaction(context),
      ),
    );
  }
}
