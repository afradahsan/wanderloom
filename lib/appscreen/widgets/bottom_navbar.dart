// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/explore_page.dart';
import 'package:wanderloom/appscreen/screens/profile_page.dart';
import 'package:wanderloom/appscreen/screens/trip_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  List pages = [];
  int selectedIndex = 0;

  @override
  void initState() {
    pages = [
      const TripPage(),
      const ExplorePage(), 
      const ProfilePage()
      ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    Widget wdivider = SizedBox(width: screenHeight/130,);

    print('navbar: $screenWidth, $screenHeight');
    return Scaffold(
      body: pages[selectedIndex],
      extendBody: true,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      height: screenHeight/9,
      width: screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Color.fromARGB(163, 1, 1, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(0, 33, 149, 243),
            blurRadius: 8,
            spreadRadius: 0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
        child: BottomNavigationBar(
          enableFeedback: true,
          currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: selectedIndex == 0 ? Container(
                height: screenHeight/27, //~=30
                width: screenHeight/9,  //~=90
                decoration: BoxDecoration(color: const Color.fromARGB(255, 190, 255, 0), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.airplane_ticket_rounded, size: screenHeight/27, color: Color.fromARGB(255, 0, 0, 0),),
                    wdivider,
                    Text('Trips', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), 
                    fontSize: screenHeight/54, //~=14
                    fontWeight: FontWeight.w600),)
                  ],
                ),
              ) : Icon(Icons.airplane_ticket_rounded, color: Color.fromARGB(255, 255, 255, 255),),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex==1 ? Container(
                height: screenHeight/26.5,
                width: screenHeight/8.5,
                decoration: BoxDecoration(color: const Color.fromARGB(255, 190, 255, 0), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore, size: screenHeight/27, color: Color.fromARGB(255, 0, 0, 0),),
                    wdivider,
                    Text('Explore', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: screenHeight/54, fontWeight: FontWeight.w600),),
                  ],
                ),
              ): Icon(Icons.explore, color: Color.fromARGB(255, 255, 255, 255),),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2 ? Container(
                height: screenHeight/27,
                width: screenHeight/9,
                decoration: BoxDecoration(color: const Color.fromARGB(255, 190, 255, 0), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: screenHeight/30, color: Color.fromARGB(255, 0, 0, 0),),
                    wdivider,
                    Text('Profile', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: screenHeight/54, fontWeight: FontWeight.w600),)
                  ],
                ),
              ): Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255),),
              label: '',
            ),
        ]),
      ),
    );
  }
}