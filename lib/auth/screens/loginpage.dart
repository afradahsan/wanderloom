// ignore_for_file: unused_local_variable, unused_field, use_build_context_synchronously, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/adminscreens/adminpage.dart';
import 'package:wanderloom/appscreen/screens/trip_page.dart';
import 'package:wanderloom/db/functions/database_services.dart';
import 'package:wanderloom/auth/functions/auth_functions.dart';
import 'package:wanderloom/auth/screens/signup.dart';
import 'package:wanderloom/auth/widgets/buttons.dart';
import 'package:wanderloom/auth/widgets/snackbar.dart';
import 'package:wanderloom/auth/widgets/tformfeild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  AuthService authService = AuthService();
  SnackBarWidget snackBarWidget = SnackBarWidget();

  bool loading = false;

  // final usernm = usernamecontroller.text.trim();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  loginuser() async{
    if(_formKey.currentState!.validate()){
      setState(() {
        loading = true;
      });
      await authService.login(emailcontroller.text.trim(), passwordController.text.trim()).then((value) async{
        if(value == 2){
        setState(() {
          loading=false;
        });
        debugPrint('admin');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
         return const AdminPage();
        }));
        }
        
        if(value==true){
        setState(() {
          loading=false;
        });
        QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserData(emailcontroller.text);       

        debugPrint('Not Admin');

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
         return const TripPage();
        }));
        }
        else{
          snackBarWidget.showSnackBar(context, value, const Color.fromARGB(255, 74, 74, 74));
        setState(() {
          loading = false;
        });
        }
      });
    }
  }

  // Future getAdmin(String adminController, String adminPassword) async{
  //   await FirebaseFirestore.instance.collection('admin').doc('adminLogin').snapshots().forEach((doc) {
  //     if(doc.data()?['adminEmail'] == adminController && doc.data()?['adminPassword'] == adminPassword){
  //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
  //         return AdminPage();
  //       }), (route) => false);
  //       }
  //   });
  // }

  // login(BuildContext context) {
  //   setState(() {
  //     loading = true;
  //   });
  //   if (_formKey.currentState!.validate()) {
  //     _auth
  //         .signInWithEmailAndPassword(
  //             email: emailcontroller.text.trim(),
  //             password: passwordController.text.trim())
  //         .then((value) {
  //           setState(() {
  //             loading = false;
  //           });
  //       UtilsToast().toastMessage(value.user!.toString());
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) {
  //         return TripPage();
  //       }));
  //     }).onError((error, stackTrace) {
  //       debugPrint(
  //           "PRINT THIS: ${error.toString()}"); //Debug print will get removed automatically whne going to release mode.
  //       UtilsToast().toastMessage(error.toString());
  //       setState(() {
  //         loading = false;
  //       });
  //     });
  //   }
  // }

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Future<UserModel?> loginuser(String username, String password) async {
    //   final user = await getUserDetails();
    //   final userlist = user.values.toList();
    //   for (UserModel users in userlist) {
    //     if (users != null &&
    //         users.username == username &&
    //         users.password == password) {
    //       return Navigator.of(context)
    //           .pushReplacement(MaterialPageRoute(builder: (context) {
    //         return TripPage(userModel: users);
    //       })); // Return the user if login is successful
    //     }
    //   }
    //   return null;
    // }

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(15),
        height: screenHeight,
        width: screenWidth,
        color: const Color.fromRGBO(21, 24, 43, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/waving-hand_1f44b.png',
              height: 70,
            ),
            const Text(
              "Welcome Back!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            const Text(
              "Log in to Continue",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TformFeild(
                      hintTXT: 'Email ID',
                      validatorreturn: 'Enter your Email ID',
                      texteditctrl: emailcontroller),
                  const SizedBox(
                    height: 7,
                  ),
                  TformFeild(
                      hintTXT: 'Password',
                      validatorreturn: 'Enter your Password',
                      texteditctrl: passwordController),
                  const SizedBox(
                    height: 10,
                  ),
                  SignupButton(
                      ButtonText: 'Log In',
                      loading: loading,
                      returnfunction: () {
                        // login(context);
                        loginuser();
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
              children: [
                const TextSpan(text: 'New User? '),
                TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                        return const SignupPage();
                        }));
                      })
              ]),
            ),
          ],
        ),
      )),
    );
  }
}
