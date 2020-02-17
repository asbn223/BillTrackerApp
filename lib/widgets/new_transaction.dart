import 'dart:io';

import 'package:bill_tracker_2/widgets/adaptiveButton.dart';
import 'package:flutter/cupertino.dart';
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
      if (double.parse(amountController.text) > 0) {
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
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Enter Product Name"),
                controller: titleController,
                onSubmitted: (_) {
                  _submitData();
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Enter Product Price"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  _submitData();
                },
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
                  AdaptiveButton(pickDate: _pickDate),
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
      ),
    );
  }
}
