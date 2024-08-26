import 'dart:math';
import 'package:expense_organizer/components/chart.dart';
import 'package:flutter/material.dart';

import 'package:expense_organizer/models/transaction.dart';
import 'package:expense_organizer/components/transaction_form.dart';
import 'package:expense_organizer/components/transaction_list.dart';

main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
        home: HomePage(),
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
          textTheme: theme.textTheme.copyWith(
            headlineLarge: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ));
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showChart = false;

  final List<Transaction> _transactions = [
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'Transação 01',
    //     value: 210.50,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'Transação 02',
    //     value: 80.20,
    //     date: DateTime.now().subtract(const Duration(days: 3))),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'Transação 03',
    //     value: 2110.29,
    //     date: DateTime.now().subtract(const Duration(days: 4))),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'Transação 04',
    //     value: 548.50,
    //     date: DateTime.now().subtract(const Duration(days: 2))),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'Transação 05',
    //     value: 45.50,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'Transação 06',
    //     value: 310.50,
    //     date: DateTime.now().subtract(const Duration(days: 1))),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'Transação 07',
    //     value: 197.50,
    //     date: DateTime.now().subtract(const Duration(days: 2))),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((item) {
        return item.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.bar_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        )
      ],
    );

    final appBarHeight = appBar.preferredSize.height;
    final statusBardHeight = mediaQuery.padding.top;

    final availableSize =
        mediaQuery.size.height - appBarHeight - statusBardHeight;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandscape)
              Container(
                  height: availableSize * (isLandscape ? 0.6 : 0.3),
                  child: Chart(recentTransactions: _recentTransactions)),
            Container(
              height: availableSize * 0.7,
              child: TransactionList(
                transactions: _transactions,
                onRemoveTransaction: _removeTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
