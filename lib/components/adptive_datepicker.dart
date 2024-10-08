import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AdptiveDatepicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdptiveDatepicker(
      {super.key, required this.selectedDate, required this.onDateChanged});

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate:
                  DateTime.now().subtract(const Duration(days: 365 * 2)),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : DateFormat('dd/MM/y').format(selectedDate!),
                  ),
                ),
                TextButton(
                    onPressed: () => _showDatePicker(context),
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ))
              ],
            ),
          );
  }
}
