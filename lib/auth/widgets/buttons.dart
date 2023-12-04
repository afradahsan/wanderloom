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

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double ten = screenHeight/(0.10*screenHeight);
    double twenty = screenWidth/(0.05*screenWidth);

    print('$screenWidth, $screenHeight, $ten, $twenty');

    return ElevatedButton(onPressed: (){
                returnfunction();
              }, 
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 31, 65, 244), minimumSize: Size.fromHeight(ten*5)),
              child: loading ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white,) : Text(ButtonText, style: TextStyle(color: Colors.white, fontSize: ten*2.2, fontWeight: FontWeight.w500),)
              );
  }
}