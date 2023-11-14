import 'package:flutter/material.dart';

class DropDownPlaceWidget extends StatefulWidget {
  DropDownPlaceWidget({required this.onValChanged, super.key});

  final ValueChanged<String?> onValChanged;

  @override
  State<DropDownPlaceWidget> createState() => _DropDownPlaceWidgetState();
}

class _DropDownPlaceWidgetState extends State<DropDownPlaceWidget> {

    String? chosenValue;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
        child: DropdownButton<String>(
          focusColor: Colors.white,
          value: chosenValue,
          elevation: 5,
          style: TextStyle(color: Colors.white),
          items: <String>[
            'Kerala',
            'Karnataka',
            'Rajasthan',
            'TamilNadu',
            'Uttar Pradesh',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: const Text(
            "Select Region",
            style: TextStyle(
              color:  Color.fromARGB(255, 255, 255, 255),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
          ),
          onChanged: (String? value) {
          setState(() {
            chosenValue = value!;
          });
          widget.onValChanged(value);
          },
          dropdownColor: const Color.fromRGBO(21, 24, 43, 1),
          ),
      ),
    );;
  }
}