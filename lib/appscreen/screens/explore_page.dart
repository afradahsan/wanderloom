import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/widgets/bottom_navbar.dart';


class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const SingleChildScrollView(
              physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text('BFWBKBJDVJWBVU')

                    ],
                  ),
                  
                ),
                Positioned(
              bottom: 16,
              left: 23,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
                height: 60,
                width: 350,
                decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(35),
                color: const Color.fromARGB(221, 1, 1, 1), boxShadow:const [BoxShadow(color: Color.fromARGB(0, 33, 149, 243), blurRadius: 8,spreadRadius: 0, blurStyle: BlurStyle.outer)] ),

                // child: BottomNavigationBar(items: [BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket_rounded, ), label: 'Trips'), BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'), BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')], backgroundColor: Colors.transparent,),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.person, color: Colors.white,)),

                    // Container(
                    //   height: 30,
                    //   width: 80,
                    //   decoration: BoxDecoration(
                    //   color: Color.fromARGB(255, 190,255, 0),
                    //   borderRadius: BorderRadius.circular(15)
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Icon(Icons.airplane_ticket_rounded,),
                    //       SizedBox(width: 5,),
                    //       Text('Trips', style: TextStyle(fontWeight: FontWeight.w600),)
                    //     ],
                    //   ),
                    // ),


                    Container(
                      height: 30,
                      width: 93,
                      decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 190,255, 0),
                      borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.explore),
                          SizedBox(width: 5,),
                          Text('Explore', style: TextStyle(fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),

                    IconButton(onPressed: (){}, icon: const Icon(Icons.person, color: Colors.white,)),

                    // Container(
                    //   height: 30,
                    //   width: 93,
                    //   decoration: BoxDecoration(
                    //   color: Color.fromARGB(255, 190,255, 0),
                    //   borderRadius: BorderRadius.circular(15)
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Icon(Icons.explore),
                    //       SizedBox(width: 5,),
                    //       Text('Explore', style: TextStyle(fontWeight: FontWeight.w600),)
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   height: 30,
                    //   width: 87,
                    //   decoration: BoxDecoration(
                    //   color: Color.fromARGB(255, 190,255, 0),
                    //   borderRadius: BorderRadius.circular(15)
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Icon(Icons.person),
                    //       SizedBox(width: 5,),
                    //       Text('Profile', style: TextStyle(fontWeight: FontWeight.w600),)
                    //     ],
                    //   )
                    // )
          ],
        )
      ),
      // bottomNavigationBar: NavigationBarTheme(data: NavigationBarThemeData(backgroundColor: const Color.fromARGB(148, 0, 0, 0)), child: NavigationBar(destinations: [NavigationDestination(icon: Icon(Icons.airplane_ticket_rounded), label: 'Trips'),
      // NavigationDestination(icon: Icon(Icons.airplane_ticket_rounded), label: 'Trips'),
      // NavigationDestination(icon: Icon(Icons.airplane_ticket_rounded), label: 'Trips'),   
      // ]))
      // GNav(
      //   backgroundColor: Color.fromARGB(34, 0, 0, 0),
      //   gap: 8,
      //   tabs: [
      // GButton(icon: Icons.airplane_ticket, text: 'Trips',),
      // GButton(icon: Icons.explore, text: 'Explore',),
      // GButton(icon: Icons.person, text: 'Profile',),
      // ]),
            ),
          ],
        ),
            
        ),
        bottomNavigationBar: BottomNav(selectedIndex: 1,),
      );
  }
}