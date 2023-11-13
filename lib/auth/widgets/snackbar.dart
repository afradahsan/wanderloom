import 'package:flutter/material.dart';

class SnackBarWidget{
  void showSnackBar(context, message, color){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.toString(), style: const TextStyle(fontSize: 14),),
    backgroundColor: color,
    duration: const Duration(seconds: 2),
    ));
  }
}