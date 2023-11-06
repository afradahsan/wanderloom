import 'package:flutter/material.dart';
import 'package:wanderloom/auth/functions/splash_functions.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    SplashServices splash = SplashServices();
    splash.isLogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43,1),
      body: SafeArea(child: 
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/wanderloom_logo.png', height: 80,),
              const Text('Wanderloom', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)
            ],
          ),
        )
      ),
    );
  }

  // Future<void> GotoOnboarding() async{
  //   await Future.delayed(Duration(seconds: 3));
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
  //     return OnboardingPage();
  //   }));
  // }
}