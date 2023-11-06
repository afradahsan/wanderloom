// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/explore_page.dart';
import 'package:wanderloom/appscreen/screens/profile_page.dart';
import 'package:wanderloom/appscreen/screens/trip_page.dart';

class BottomNav extends StatefulWidget {
  int selectedIndex;
  BottomNav({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
      height: 65,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          3,(index) => buildNavItem(index),
        ),
      ),
    );
  }

  Widget buildNavItem(int index) {
    return widget.selectedIndex == index
        ? GestureDetector(
            onTap: () {
            },
            child: Container(
              height: 30,
              width: 93,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 255, 0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(getIconForIndex(index)),
                    const SizedBox(width: 5),
                    Text(
                      getLabelForIndex(index),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          )
        : IconButton(
            onPressed: () {
              setState(() {
                widget.selectedIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TripPage()));
                  break;
                case 1:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ExplorePage()));
                  break;
                case 2:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                  break;
              }
            },
            icon: Icon(
              getIconForIndex(index),
              color: const Color.fromARGB(255, 255, 255, 255),
              size: 28,
            ),
          );
  }

  IconData getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.airplane_ticket_rounded;
      case 1:
        return Icons.explore;
      case 2:
        return Icons.person;
      default:
        return Icons.airplane_ticket_rounded;
    }
  }

  String getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Trips';
      case 1:
        return 'Explore';
      case 2:
        return 'Profile';
      default:
        return 'Trips';
    }
  }
}
