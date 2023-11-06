import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/auth/screens/loginpage.dart';
import 'package:wanderloom/auth/screens/signup.dart';
import 'package:wanderloom/auth/widgets/buttons.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  final divider = const SizedBox(height: 10,);

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child:  Container(
          decoration: const BoxDecoration(color: Colors.black),
          height: screenHeight,
          width: screenWidth,
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/wanderloom_logo.png' ,height: 55,),
                  const Text('Wanderloom', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500),),
                ],
              ),

              Image.asset('assets/images/3d_earth_wlonboarding.png', height: 390),

              const Text('Your one stop solution for all travel needs!', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w600, height: 1.3),),

              divider,
              
              SignupButton(ButtonText: 'Get Started', returnfunction: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  return const SignupPage();
                }));
              }),

              divider,

              RichText(text:  TextSpan(
                style: const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300,),
                children: [
                const TextSpan(
                  text: 'Already a Member, '
                ),
                TextSpan(
                  text: 'Log In',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(255,74, 103, 255)
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return const LoginPage();
                    }));
                  }
                )
                ]
              ))
            ],
          ),
        )
        ),
    );
  }
}