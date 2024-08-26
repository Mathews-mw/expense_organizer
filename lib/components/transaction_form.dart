import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final transactionTitleController = TextEditingController();
  final transactionValueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = transactionTitleController.text;
    final value = double.tryParse(transactionValueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
              ),
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
                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'Nenhuma data selecionada'
                                : DateFormat('dd/MM/y').format(_selectedDate!),
                          ),
                        ),
                        TextButton(
                            onPressed: _showDatePicker,
                            child: Text(
                              'Selecionar Data',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text(
                            'Nova Transação',
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
