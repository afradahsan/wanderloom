import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownWidget> {

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
          style: TextStyle(color: Colors.white),
          items: <String>[
            'Trekking/Adventure',
            'Historical & Heritage Sites',
            'Nature & Wildlife',
            'Beaches',
            'Pilgrimage sites',
            'Urban exploration',
            'Unique & offbeat places'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Text(
            "Choose Category",
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
          ),
          onChanged: (String? value) {
          setState(() {
            chosenValue = value!;
          });
          },
          dropdownColor: const Color.fromRGBO(21, 24, 43, 1),
          ),
      ),
    );
  }
}