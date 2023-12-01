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
    return Scaffold(
      body: pages[selectedIndex],
      extendBody: true,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      height: 73,
      width: 350,
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
                height: 30,
                width: 90,
                decoration: BoxDecoration(color: const Color.fromARGB(255, 190, 255, 0), borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.airplane_ticket_rounded, size: 30, color: Color.fromARGB(255, 0, 0, 0),),
                    SizedBox(width: 5,),
                    Text('Trips', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14, fontWeight: FontWeight.w600),)
                  ],
                ),
              ) : Icon(Icons.airplane_ticket_rounded, color: Color.fromARGB(255, 255, 255, 255),),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex==1 ? Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(color: const Color.fromARGB(255, 190, 255, 0), borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore, size: 30, color: Color.fromARGB(255, 0, 0, 0),),
                    SizedBox(width: 5,),

                    Text('Explore', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),),
                  ],
                ),
              ): Icon(Icons.explore, color: Color.fromARGB(255, 255, 255, 255),),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2 ? Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(color: const Color.fromARGB(255, 190, 255, 0), borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 25, color: Color.fromARGB(255, 0, 0, 0),),
                    SizedBox(width: 5,),

                    Text('Profile', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),)
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