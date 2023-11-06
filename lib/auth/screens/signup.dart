// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/trip_page.dart';
import 'package:wanderloom/auth/functions/auth_functions.dart';
import 'package:wanderloom/auth/widgets/buttons.dart';
import 'package:wanderloom/auth/widgets/snackbar.dart';
import 'package:wanderloom/auth/widgets/tformfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final String? uid = AuthService().userid;
  final _formKey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final passwordController = TextEditingController();
  final cnfPasswordController =TextEditingController();

  SnackBarWidget snackbarWidget = SnackBarWidget();

  FirebaseAuth _auth = FirebaseAuth.instance; 

  bool loading = false;

  AuthService authService = AuthService();

  void registerUser() async{
    
    if(_formKey.currentState!.validate()){
      setState(() {
        loading = true;
      });
      await authService.registerUser(emailcontroller.text.toString(), usernamecontroller.text.toString(), passwordController.text.toString(), ).then((value){
        if(value==true){
        setState(() {
          loading=false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
         return const TripPage();
        }));
        }
        else{
          snackbarWidget.showSnackBar(context, value, Colors.red);
        setState(() {
          loading = false;
        });
        }
      });
    }
  }

  // void signupfunction(){
  //   if(_formKey.currentState!.validate()){
  //     setState(() {
  //     loading = true;
  //     
  //     _auth.createUserWithEmailAndPassword(email: emailcontroller.text.toString(), password: passwordController.text.toString()).then((value) {
  //       setState(() {
  //         loading = false;
  //       });
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
  //       return TripPage();
  //     }));
  //     }).onError((error, stackTrace) {
  //       UtilsToast().toastMessage(error.toString());
  //       setState(() {
  //         loading=false;
  //       });
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(color: Color.fromRGBO(21, 24, 43, 1)),
            height: screenHeight,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/bus_vehicle_signup.png',
                  height: 90,
                ),
                const Text(
                  "Let's Get Started!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
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
                        height: 12,
                      ),
                      TformFeild(
                          hintTXT: 'Username',
                          validatorreturn: 'Enter Username',
                          texteditctrl: usernamecontroller),
                      const SizedBox(
                        height: 12,
                      ),
                      TformFeild(
                          hintTXT: 'Set a Password',
                          validatorreturn: 'Enter Password',
                          texteditctrl: passwordController),
                      const SizedBox(
                        height: 12,
                      ),
                      TformFeild(
                          hintTXT: 'Confirm Password',
                          validatorreturn: "Password doesn't match",
                          texteditctrl: cnfPasswordController),
                      const SizedBox(
                        height: 15,
                      ),
                      SignupButton(
                        ButtonText: 'Sign Up',
                        loading: loading,
                        returnfunction: () async {
                          registerUser();
                          // final usernm = usernamecontroller.text.trim();
                          // final emailid = emailcontroller.text.trim();
                          // final pswrd = passwordController.text.trim();
                          // final cnfpswrd = cnfPasswordController.text.trim();
                          
                          // signupfunction();
                          // authService.registerUser(emailcontroller.text.toString(), usernamecontroller.text.toString(), passwordController.text.toString());

                          // final success =
                          //     await onSignup(usernm, emailid, pswrd, cnfpswrd);
                          // if (success) {
                          //   final userModel = UserModel(
                          //     username: usernm,
                          //     email: emailid,
                          //     password: pswrd,
                          //   );
                            // The user was successfully signed up
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(builder: (ctx) {
                            //   return TripPage(userModel: userModel);
                            // }));
                        //   } else {
                        //     // Handle the case where the sign-up was not successful
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(content: Text('Sign-up failed')));
                        //   }
                        // },
          } )
        
                      // SignupButton(
                      //   ButtonText: 'Sign Up',
                      //   returnfunction: () async {
                      //     final usernm = usernamecontroller.text.trim();
                      //     final emailid = emailcontroller.text.trim();
                      //     final pswrd = passwordController.text.trim();
                      //     final cnfpswrd = cnfPasswordController.text.trim();
                      //     // final returnfn = validator
                      //     if (await onSignup(
                      //       usernm,
                      //       emailid,
                      //       pswrd,
                      //       cnfpswrd,
                      //     ) //Always call functions before giving navigation.
                      //         ) {
                      //       Navigator.of(context).pushReplacement(
                      //         MaterialPageRoute(builder: (ctx) {
                      //           return const TripPage();
                      //         }),
                      //       );
                      //       print('SUCCESSFULLY SIGNED IN!');
                      //     } else {
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username Already Exists!')));
                      //       print('USERNAME EXISTSS!!');
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<bool> onSignup(String usernm, String emailid, String pswrd, String cnfpswrd) async {
  //     if (usernm.length >= 4 && pswrd.length >= 6 && pswrd == cnfpswrd) {
  //       final userBox = await Hive.box<UserModel>('signup_db');
  //     if (userBox.values.any((user) => user.username == usernm)) {
  //       // Username already exists
  //       print('username exists');
  //       await userBox.close();
  //       return false;
  //     }
  //     final user = UserModel(username: usernm, email: emailid, password: pswrd);
  //     addUserDetails(user);
  //     // await userBox.add(user);
  //     // Using `add` to auto-generate a unique key for each user
  //     // await userBox.close();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  // if(usernm.isEmpty || emailid.isEmpty || pswrd.isEmpty){
  //   return;
  // }
  // else{
  //   print(' FIRST PRINT: $usernm $emailid $pswrd $cnfpswrd');
  //   final signup = UserModel(username: usernm, email: emailid, password: pswrd, tripdetailslist: []);
  //   addUserDetails(signup);
  //   print('PRINTING AGAIN: $usernm $emailid $pswrd $cnfpswrd');
  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
  //   return const TripPage();
  // }));
}
