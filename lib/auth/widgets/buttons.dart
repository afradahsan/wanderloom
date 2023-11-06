// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {

  final String ButtonText;
  final Function() returnfunction;
  final bool loading;

  const SignupButton({super.key, 
    required this.ButtonText,
    required this.returnfunction,
    this.loading = false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
                returnfunction();
              }, 
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 31, 65, 244), minimumSize: const Size.fromHeight(50)),
              child: loading ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white,) : Text(ButtonText, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),)
              );
  }
}