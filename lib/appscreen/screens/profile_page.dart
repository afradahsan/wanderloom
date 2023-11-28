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
  AuthService authService = AuthService();

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              width: double.infinity,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/images/man_professional_coatandsuitt.jpg',
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
                const Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                      size: 20,
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Afrad Ahsan',
              style: TextStyle(
                  color: Color.fromARGB(255, 190, 255, 0),
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            const Text(
              'afradahsan02@gmail.com',
              style: TextStyle(
                  color: Color.fromARGB(88, 255, 255, 255),
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
            ListTile(
              title: const Text(
                'Location & Permissions',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              leading: const Icon(
                Icons.settings,
                color: Color.fromARGB(198, 255, 255, 255),
              ),
              minLeadingWidth: 15,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SearchScreen();
                }));
              },
            ),
            ListTile(
              title: const Text(
                'Help & Support',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              leading: const Icon(
                Icons.support_agent,
                color: Color.fromARGB(198, 255, 255, 255),
              ),
              minLeadingWidth: 15,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SearchScreen();
                }));
              },
            ),
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              leading: const Icon(
                Icons.logout,
                color: Color.fromARGB(198, 255, 255, 255),
              ),
              minLeadingWidth: 15,
              onTap: () {
                authService.signOut(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              color: Colors.white,
              onPressed: () {
                authService.signOut(context);
              },
            )
          ]),
        ),
      ),
    );
  }
}
