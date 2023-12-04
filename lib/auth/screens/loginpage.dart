// ignore_for_file: unused_local_variable, unused_field, use_build_context_synchronously, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/adminscreens/adminpage.dart';
import 'package:wanderloom/appscreen/screens/trip_page.dart';
import 'package:wanderloom/appscreen/widgets/bottom_navbar.dart';
import 'package:wanderloom/auth/screens/forgotpassw.dart';
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
         return const BottomNav();
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
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double ten = screenHeight/(0.10*screenHeight);
    double twenty = screenWidth/(0.05*screenWidth);

    print('$screenWidth, $screenHeight, $ten, $twenty');

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
        padding: EdgeInsets.all(ten*1.5),
        height: screenHeight,
        width: screenWidth,
        color: const Color.fromRGBO(21, 24, 43, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/waving-hand_1f44b.png',
              height: ten*7,
            ),
            Text(
              "Welcome Back!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ten*3,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Log in to Continue",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ten*1.6,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: ten,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TformFeild(
                      hintTXT: 'Email ID',
                      validatorreturn: 'Enter your Email ID',
                      texteditctrl: emailcontroller),
                  SizedBox(
                    height: ten*0.7,
                  ),
                  TformFeild(
                      hintTXT: 'Password',
                      validatorreturn: 'Enter your Password',
                      texteditctrl: passwordController),
                  SizedBox(
                    height: ten,
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
            SizedBox(
              height: ten,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: const Color.fromRGBO(255, 255, 255, 0.7),
                    fontSize: ten*1.4,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    const TextSpan(text: 'New User? '),
                    TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(33, 150, 243, 0.7)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                            return const SignupPage();
                            }));
                          })
                  ]),
                ),
                RichText(
                  text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: const Color.fromRGBO(255, 255, 255, 0.7),
                    fontSize: ten*1.4,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    const TextSpan(text: '  |  '),
                    TextSpan(
                        text: 'Forgot Passsword?',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(33, 150, 243, 0.7)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                            return const ForgotPassword();
                            }));
                          })
                  ]),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}