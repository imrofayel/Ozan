import 'package:flutter/material.dart';

Future<DateTime> showDatePickerDialog(BuildContext context) async {
  DateTime selectedDate = DateTime.now();

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (picked != null && picked != selectedDate) {
    return picked;
  }

  return selectedDate;
}
