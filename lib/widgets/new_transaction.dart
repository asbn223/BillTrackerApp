import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();

  final amountController = new TextEditingController();

  void _submitData() {
    if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
      if (!double.parse(amountController.text).isNegative) {
        String title = titleController.text;
        double amount = double.parse(amountController.text);

        widget.addTx(title, amount);
        Navigator.pop(contex
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Enter Product Name"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Enter Product Price"),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Text(
                "Add Product",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _submitData,
              color: Colors.blueGrey,
            )
          ],
        ),
      ),
    );
  }
}
