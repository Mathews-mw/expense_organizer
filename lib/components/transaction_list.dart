import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) onRemoveTransaction;

  TransactionList(
      {super.key,
      required this.transactions,
      required this.onRemoveTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 570,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    'Nenhuma transação cadastrada.',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ]);
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final transaction = transactions[index];

                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('R\$${transaction.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    subtitle:
                        Text(DateFormat('d MMM y').format(transaction.date)),
                    trailing: IconButton(
                        onPressed: () => onRemoveTransaction(transaction.id),
                        icon: const Icon(Icons.delete_forever)),
                    iconColor: Theme.of(context).colorScheme.error,
                  ),
                );
              },
            ),
    );
  }
}
