import 'package:bill_tracker_2/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bill Tracker",
      home: BillPage(),
    );
  }
}

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  List<Transaction> userTranscation = [
    Transaction(title: "Glass", amount: 100.00, date: DateTime.now()),
    Transaction(title: "Shirts", amount: 150.00, date: DateTime.now()),
    Transaction(title: "Shoes", amount: 500.00, date: DateTime.now())
  ];

  String title;
  double amount;

  void addProduct(String title, double amount) {
    final newTrans =
        new Transaction(title: title, amount: amount, date: DateTime.now());
    setState(() {
      userTranscation.add(newTrans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Tracker"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("Chart"),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration:
                          InputDecoration(labelText: "Enter Product Name"),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    TextField(
                      decoration:
                          InputDecoration(labelText: "Enter Product Price"),
                      onChanged: (value) {
                        amount = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                    ),
                    RaisedButton(
                      child: Text(
                        "Add Product",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        addProduct(title, amount);
                      },
                      color: Colors.blueGrey,
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: userTranscation.map((tx) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "\$" + tx.amount.toString(),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMEd().add_jms().format(tx.date),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
