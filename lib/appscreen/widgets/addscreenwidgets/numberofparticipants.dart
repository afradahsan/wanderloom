// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerDialog extends StatefulWidget {
  final int initialValue;

  const NumberPickerDialog({super.key, required this.initialValue});

  @override
  _NumberPickerDialogState createState() => _NumberPickerDialogState();
}

class _NumberPickerDialogState extends State<NumberPickerDialog> {
  int _currentValue = 1;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      title: const Text('Choose no.', style: TextStyle(color: Colors.white),),
      content: NumberPicker(
        minValue: 1,
        maxValue: 100,
        haptics: true,
        textStyle: const TextStyle(color: Colors.white),
        selectedTextStyle: const TextStyle(color: Color.fromARGB(255, 190, 255, 0)),
        value: _currentValue,
        onChanged: (value) {
          print('Selected value: $value');
          setState(() {
            _currentValue = value; // Update the selected value
            print('the value is $_currentValue');
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            print('Close button pressed');
            Navigator.pop(context);
          },
          child: const Text('Close', style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),)),
        ),
        TextButton(
          onPressed: () {
            print('Save button pressed. Current value: $_currentValue');
            Navigator.pop(context, _currentValue); // Return the selected value when saved
          },
          child: const Text('Save', style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),)),
        ),
      ],
    );
  }
}
