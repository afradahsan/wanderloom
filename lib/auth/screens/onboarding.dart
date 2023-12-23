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

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double ten = screenHeight/(0.10*screenHeight);
    double twenty = screenWidth/(0.05*screenWidth);

    print('$screenWidth, $screenHeight, $ten, $twenty');

    return Scaffold(
      body: SafeArea(
        child:  Container(
          decoration: const BoxDecoration(color:  Color.fromRGBO(21, 24, 43,1),),
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.fromLTRB(twenty, ten*3, twenty, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/wanderloom_logo.png' ,height: ten*5.5,),
                  Text('Wanderloom', style: TextStyle(color: Colors.white, fontSize: ten*3.6, fontWeight: FontWeight.w500),),
                ],
              ),

              Image.asset('assets/images/3d_earth_wlonboarding.png', height: ten*39),

              Text('Your one stop solution for all travel needs!', style: TextStyle(color: Colors.white, fontSize: ten*4.2, fontWeight: FontWeight.w600, height: 1.3),),

              divider,
              
              SignupButton(ButtonText: 'Get Started', returnfunction: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  return const SignupPage();
                }));
              }),

              divider,

              RichText(text:  TextSpan(
                style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: ten*1.4, fontWeight: FontWeight.w300,),
                children: [
                const TextSpan(
                  text: 'Already a Member, '
                ),
                TextSpan(
                  text: 'Log In',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(208, 74, 104, 255)
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