// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DatetimePicker extends StatefulWidget {
  const DatetimePicker({super.key, required this.onDateSelected, required this.onTimeSelected});

  final Function(DateTime) onDateSelected;
  final Function(TimeOfDay) onTimeSelected;

  @override
  State<DatetimePicker> createState() => _DatetimePickerState();
}

  class _DatetimePickerState extends State<DatetimePicker> {

    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    
    DateTime dateTime = DateTime.now();
    bool showDate = false;
    bool showTime = false;
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

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }


  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
      if (date == null) return;

    final time = await _selectTime(context);

      if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });

    widget.onDateSelected(selectedDate);
    widget.onTimeSelected(selectedTime);
  }

  String getTime(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
    }

  String getDate() {
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('d, MMM').format(selectedDate);
    }
  }

  String getDateTime() {
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('d MMM, HH:ss a').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_month_rounded, size: 12, color: Color.fromARGB(255, 190,255, 0),),
              SizedBox(width: 5,),
              Text('Trip Date', style: TextStyle(color: Color.fromARGB(255, 190,255, 0), fontSize: 12),),
            ],
          ),

          TextButton(style: TextButton.styleFrom(side: const BorderSide(width: 1, color: Colors.white)), onPressed: (){
            _selectDateTime(context);
          },child: Text(getDateTime(), style: const TextStyle(color: Colors.white, fontSize: 15 )),),
        ],
      );
  }
}