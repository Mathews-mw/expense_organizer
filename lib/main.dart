import 'package:expense_organizer/models/transaction.dart';
import 'package:flutter/material.dart';

main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Tênis de corrida',
        value: 499.99,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Conta de energia',
        value: 121.50,
        date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Almoço especial', value: 89.75, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: const Card(
              child: Text('Gráfico'),
            ),
          ),
          Column(
            children: _transactions.map((transaction) {
              return Card(
                child: Text(transaction.title),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
