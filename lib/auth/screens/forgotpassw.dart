// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Forgot Password?', style: TextStyle(color: Color.fromARGB(255, 190,255, 0), fontSize: 25, fontWeight: FontWeight.w600),),
            SizedBox(height: 5,),
            const Text("Don't worry, we've got you covered!", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w300),),
            SizedBox(height: 15,),
            Textfeildtrip(textformlabel: 'Email ID', textformhinttext: 'example@gmail.com', textformIconPrefix: Icons.mail, addtripController: emailController,),
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.centerRight,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: (){
                  print('going');
                  forgotPassword();}, 
                label: Text('Proceed', style: TextStyle(color: const Color.fromRGBO(21, 24, 43, 1),),), style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 190,255, 0)),
                icon: const Icon(Icons.arrow_back_ios, color:  Color.fromRGBO(21, 24, 43, 1), size: 17,),),
              ),
            ),
          ],
        ),
      )),
    );
  }
  
  void forgotPassword() async {
  String email = emailController.text.trim();
  
  if (email.isNotEmpty) {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
      showDialog(context: context, builder: (context){
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
          content: Text('Password reset link has been sent to $email', style: TextStyle(color: const Color.fromARGB(255, 190,255, 0)),),
          actions: [TextButton(onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            }, child: Text('OK'))],
        );
      });
    } on FirebaseAuthException catch (e) {
      print('Error message: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    }
  } else {
    // Handle case where email is empty
    print('Email address is empty');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter your email address')),
    );
  }
}

}