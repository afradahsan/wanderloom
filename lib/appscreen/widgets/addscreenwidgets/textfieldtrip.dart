// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

class Textfeildtrip extends StatelessWidget {

  Textfeildtrip(
    {super.key, 
    this.addtripController,
    this.inputType,
    this.maxLines,
    required this.textformlabel,
    required this.textformhinttext,
    required this.textformIconPrefix
    }
  );

  final String textformlabel;
  final String textformhinttext;
  final IconData textformIconPrefix;
  late TextInputType? inputType;
  final int? maxLines;

  final addtripController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: addtripController,
      style: const TextStyle(color: Colors.white),
      keyboardType: inputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 190,255, 0))
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        fillColor: Colors.white,
        focusColor: Colors.white,
        prefixIcon: Icon(textformIconPrefix, color: const Color.fromARGB(255, 190,255, 0),size: 20,),
        labelText: textformlabel,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        hintText: textformhinttext,
        hintStyle: const TextStyle(color: Color.fromARGB(103, 255, 255, 255))
      ),
      );
  }
}