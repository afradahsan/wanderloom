import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/trip_page.dart';
import 'package:wanderloom/auth/screens/onboarding.dart';

class SplashServices{

    void isLogin(BuildContext context){
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      
    if(user!=null){
    Timer(const Duration(seconds: 3),()=>
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return const TripPage();
    })));
    }
    else{
      Timer(const Duration(seconds: 3),()=>
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return const OnboardingPage();
    })));
    }
    }
  }
  // Future<void> isNewUser(BuildContext context) async{
  //   await Future.delayed(Duration(seconds: 3));
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
  //     return OnboardingPage();
  //   }));
  // }