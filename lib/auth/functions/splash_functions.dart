import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/adminscreens/adminpage.dart';
import 'package:wanderloom/appscreen/screens/trip_page.dart';
import 'package:wanderloom/appscreen/widgets/bottom_navbar.dart';
import 'package:wanderloom/auth/screens/onboarding.dart';

class SplashServices{

    void isLogin(BuildContext context){
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      print("user $user");
    if(user!=null){
      if(user!.uid == "BarF8kEyiuQ7ps3pupuFqpBJ0dZ2"){
        Timer(const Duration(seconds: 3),()=>
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return const AdminPage();
    })));
    }else{
    Timer(const Duration(seconds: 3),()=>
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return const BottomNav();
    })));
    }
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