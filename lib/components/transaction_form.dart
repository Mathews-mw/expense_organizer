import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final transactionTitleController = TextEditingController();

  final transactionValueController = TextEditingController();

  _submitForm() {
    final title = transactionTitleController.text;
    final value = double.tryParse(transactionValueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: transactionTitleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: transactionValueController,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal:
                          true), // numberWithOptions -> para que as opções no teclado do ios funcione
                  onSubmitted: (_) => _submitForm(),
                  decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        onPressed: _submitForm,
                        child: const Text(
                          'Nova Transação',
                          style: TextStyle(color: Colors.purple),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
