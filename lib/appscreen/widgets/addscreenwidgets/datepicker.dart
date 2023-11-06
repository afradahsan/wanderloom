// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.onDateSelected});

  final Function(DateTime) onDateSelected;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

  class _DatePickerState extends State<DatePicker> {

    DateTime selectedDate = DateTime.now();
    DateTime dateTime = DateTime.now();
    bool showDate = false;
    bool showDateTime = false;

    Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
      if (date == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
      );
    });
    widget.onDateSelected(selectedDate);
  }

  String getDate() {
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('d MMM, yyyy').format(selectedDate);
    }
  }

  String getDateTime() {
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('dth MMM').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_month_rounded, size: 14, color: Color.fromARGB(255, 190,255, 0),),
              SizedBox(width: 5,),
              Text('Expense Date', style: TextStyle(color: Color.fromARGB(255, 190,255, 0), fontSize: 16),),
            ],
          ),
          const SizedBox(height: 5,),

          TextButton(style: TextButton.styleFrom(side: const BorderSide(width: 1, color: Colors.white)), onPressed: (){
            _selectDateTime(context);
          },child: Text(getDate(), style: const TextStyle(color: Colors.white, fontSize: 15 )),),
        ],
      );
  }
}