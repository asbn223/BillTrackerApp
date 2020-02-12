import 'package:bill_tracker_2/model/transaction.dart';
import 'package:bill_tracker_2/widgets/chartbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedExpenses {
    return List.generate(7, (index){
          final weekDay = DateTime.now().subtract(Duration(days: index));
          double totalSum = 0.0;
          return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
        });
      }
      
    
      @override
      Widget build(BuildContext context) {
        return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: 
                  Row(
                    children: groupedExpenses.map((tx){
                        return ChartBar();
                      }).toList(),
                  ),
                ),
            );
      }
    }
    