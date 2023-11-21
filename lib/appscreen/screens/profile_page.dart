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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,25,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(width: double.infinity,),
            
            CircleAvatar(backgroundColor: Colors.amber,radius: 50, child: Image.asset('assets/images/money-with-wings_emoji_1f4b8.png', height: 60,),),SizedBox(height: 10,),
            Text('Afrad Ahsan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 30),),

            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text('data'),
                );
            }, separatorBuilder: (context, index){
              return Divider();
            }, itemCount: 5),
            
            IconButton(icon: const Icon(Icons.logout_outlined), color: Colors.white, onPressed: (){
              authService.signOut(context);
            },)
          ]),
        ),
      ),
      bottomNavigationBar: BottomNav(selectedIndex: 2,),
    );
  }
}