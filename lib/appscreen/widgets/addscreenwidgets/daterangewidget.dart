// ignore_for_file: unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMM d, yyyy').format(now);

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';


  

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('MMM d, yyyy').format(args.value.startDate)} - ' '${DateFormat('MMM d, yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    return  Row(
    children: [
      Column(
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
            _showAlertDialog();
          },child: Text(formattedDate, style: const TextStyle(color: Colors.white, fontSize: 15 )),),
        ],
      ),
    ],
    );
  }

  Future<void> _showAlertDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 230,
          child: SfDateRangePicker(
        // backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        // rangeTextStyle: TextStyle(color: Colors.white),
        // selectionTextStyle: TextStyle(color: Colors.white),
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.range,
        minDate: DateTime(1940,1,1),
        maxDate: DateTime(2100,12,31),
        onSelectionChanged: _onSelectionChanged,
        initialSelectedRange: PickerDateRange(DateTime.now(),DateTime.now()),
      ),
      ),
      actions: [
        TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              setState(() {
                formattedDate = _range;
                print(formattedDate);
              });
              Navigator.of(context).pop();
            },
          ),
      ],
      );
    },
  );
}
}