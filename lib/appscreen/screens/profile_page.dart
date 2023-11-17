import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/widgets/bottom_navbar.dart';
import 'package:wanderloom/auth/functions/auth_functions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // final _auth = FirebaseAuth.instance;

  AuthService authService = AuthService();

  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Your Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 
            20),),
            // CircleAvatar(backgroundColor: Colors.amber,)
          // IconButton(icon: const Icon(Icons.logout_outlined), color: Colors.white, onPressed: (){
          //   authService.signOut(context);
          //   // _auth.signOut().then((value){
          //   //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
          //   //     return LoginPage();
          //   //   }), (route) => false);
          //   // }).onError((error, stackTrace){
          //   //   UtilsToast().toastMessage(error.toString());
          //   // });
          // },)
        ],),
      ),
      bottomNavigationBar: BottomNav(selectedIndex: 2,),
    );
  }
}