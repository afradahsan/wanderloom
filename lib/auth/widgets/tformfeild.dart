import 'package:flutter/material.dart';

class TformFeild extends StatelessWidget {

  final String hintTXT;
  final String validatorreturn;
  final TextEditingController texteditctrl;

  const TformFeild({super.key, 
    required this.hintTXT,
    required this.validatorreturn,
    required this.texteditctrl
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
    controller: texteditctrl,
    decoration: InputDecoration(
      fillColor: Colors.white,
      focusedBorder: const OutlineInputBorder( borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 46, 102, 255)),),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      enabledBorder: OutlineInputBorder(
      borderSide:
        const BorderSide(width: 1, color: Color.fromARGB(196, 255, 255, 255)),
      borderRadius: BorderRadius.circular(5.0),
      ),
      hintText: hintTXT,
      hintStyle: const TextStyle(color: Color.fromARGB(111, 255, 255, 255), )
    ),
    
    validator: (value) {
      if(value == null || value.isEmpty){
        return validatorreturn;
      }
      else{
        return null;
      }
    },
    );
  }
}