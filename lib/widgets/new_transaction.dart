import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();

  final amountController = new TextEditingController();

  DateTime _selectedDateTime;

  void _submitData() {
    if (titleController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        _selectedDateTime != null) {
      if (!double.parse(amountController.text).isNegative &&
          double.parse(amountController.text) > 0) {
        String title = titleController.text;
        double amount = double.parse(amountController.text);

        widget.addTx(title, amount, _selectedDateTime);
        Navigator.pop(context);
      }
    } else {
      return;
    }
  }

  void _pickDate(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((selectedDate) {
      setState(() {
        _selectedDateTime = selectedDate;
      });
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDateTime == null
                      ? "No Date chosen"
                      : "Picked Date: ${DateFormat.yMd().format(_selectedDateTime).toString()}",
                  style: TextStyle(fontSize: 14),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Choose a date",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontFamily: "font1", fontSize: 16),
                  ),
                  onPressed: () => _pickDate(context),
                )
              ],
            ),
            RaisedButton(
              child: Text(
                "Add Product",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _submitData,
              color: Theme.of(context).accentColor,
            )
          ],
        ),
      ),
    );
  }
}
