import 'package:expense_organizer/components/chart_bar.dart';
import 'package:expense_organizer/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool isSameDay = recentTransactions[i].date.day == weekDay.day;
        bool isSameMonth = recentTransactions[i].date.month == weekDay.month;
        bool isSameYear = recentTransactions[i].date.year == weekDay.year;

        if (isSameDay && isSameMonth && isSameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      final weekDayFirstLatter = DateFormat.E().format(weekDay)[0];

      return {
        'day': weekDayFirstLatter,
        'value': totalSum,
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (acc, item) {
      return acc += (item['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((groupTr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: groupTr['day'].toString(),
                value: double.parse(groupTr['value'].toString()),
                percentage: (groupTr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
