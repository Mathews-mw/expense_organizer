import 'dart:math';

import 'package:expense_organizer/components/transaction_form.dart';
import 'package:expense_organizer/components/transaction_list.dart';
import 'package:expense_organizer/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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
        id: 't3', title: 'Despesa #03', value: 121.50, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'Despesa #04', value: 150.00, date: DateTime.now()),
    Transaction(
        id: 't5', title: 'Despesa #05', value: 223.47, date: DateTime.now()),
    Transaction(
        id: 't6', title: 'Despesa #06', value: 89.11, date: DateTime.now()),
    Transaction(
        id: 't7', title: 'Despesa #07', value: 321.15, date: DateTime.now()),
    Transaction(
        id: 't8', title: 'Despesa #08', value: 77.47, date: DateTime.now()),
    Transaction(
        id: 't9', title: 'Despesa #09', value: 189.78, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(
          onSubmit: _addTransaction,
        ),
        TransactionList(transactions: _transactions),
      ],
    );
  }
}
