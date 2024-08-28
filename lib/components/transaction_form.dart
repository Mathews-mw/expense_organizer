import 'package:expense_organizer/components/adaptive_button.dart';
import 'package:expense_organizer/components/adaptive_textfield.dart';
import 'package:expense_organizer/components/adptive_datepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

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
                  AdaptiveTextfield(
                    controller: transactionTitleController,
                    label: 'Título',
                    onSubmitted: (_) => _submitForm(),
                  ),
                  AdaptiveTextfield(
                    controller: transactionValueController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal:
                            true), // numberWithOptions -> para que as opções no teclado do ios funcione
                    onSubmitted: (_) => _submitForm(),
                    label: 'Valor (R\$)',
                  ),
                  AdptiveDatepicker(
                      selectedDate: _selectedDate,
                      onDateChanged: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AdaptiveButton(
                        label: 'Nova Transação',
                        onPressed: _submitForm,
                      ),
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
