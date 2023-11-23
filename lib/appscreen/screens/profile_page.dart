import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/searchscreen.dart';
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

  final profileSection = ['Location & Permissions', 'Currency Preferences','Help & Support', 'Log Out'];

  final profileIcons = [Icons.settings, Icons.currency_rupee, Icons.support_agent, Icons.logout];

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
            const SizedBox(width: double.infinity,),
            
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset('assets/images/man_professional_coatandsuitt.jpg', fit: BoxFit.cover, height: 80, width: 80,),),
                  Positioned(bottom: 0,right: 0, child: Icon(Icons.photo_camera, color: Colors.white,size: 20,))
              ],
            ),
            const SizedBox(height: 10,),
            const Text('Afrad Ahsan', style: TextStyle(color:  Color.fromARGB(255, 190, 255, 0), fontWeight: FontWeight.w500, fontSize: 20),),
            const Text('afradahsan02@gmail.com', style: TextStyle(color: Color.fromARGB(88, 255, 255, 255), fontWeight: FontWeight.w300, fontSize: 12),),

            ListView.separated(
              padding: const EdgeInsets.only(left: 12),
              shrinkWrap: true,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(profileSection[index], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                  leading: Icon(profileIcons[index], color: Color.fromARGB(198, 255, 255, 255),),
                  minLeadingWidth: 15,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){return SearchScreen();}));
                  },
                );
            }, separatorBuilder: (context, index){
              return const Divider();
            }, itemCount: 4),
            
            IconButton(icon: const Icon(Icons.logout_outlined), color: Colors.white, onPressed: (){
              authService.signOut(context);
            },)
          ]),
        ),
      ),
      // bottomNavigationBar: BottomNav(),
    );
  }
}