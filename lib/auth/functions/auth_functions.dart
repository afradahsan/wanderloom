// ignore_for_file: unnecessary_null_comparison, unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/db/functions/database_services.dart';
import 'package:wanderloom/auth/screens/loginpage.dart';
import 'package:wanderloom/auth/widgets/utilstoast.dart';

class AuthService{
  String? userid;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //register user
  Future registerUser(String email, String username, String password) async{
    try{
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;

      if(user!=null){
        await DatabaseService(uid: user.uid).saveUserData(email, username);
        final userid = user.uid;
        // this.userid = user.uid;
        return true;
      }
    } on FirebaseAuthException catch(e){
      print(e);
      return e.message;
    }
  }

  //Login Function
  Future login(String email, String password) async{
    try{
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;

      if(user!=null){
        return true;
      }
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  //Sign Out
  Future signOut(context) async{
    firebaseAuth.signOut().then((value){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
              return const LoginPage();
            }), (route) => false);
          }).onError((error, stackTrace){
            UtilsToast().toastMessage(error.toString());
          });
  }
}