import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/addnewtrip.dart';
import 'package:wanderloom/appscreen/widgets/bottom_navbar.dart';
import 'package:wanderloom/appscreen/widgets/floatingbutton.dart';
import 'package:wanderloom/appscreen/widgets/tripinfo.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  
  int selectedIndex = 0;
  List<Map<String, dynamic>> trips = [];
  // List<TripDetailsModel> trip = [];
  // final _auth = FirebaseAuth.instance;
  // final currentuser = _auth.currentUser;

  String? uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    getTrips();
    // getTripDetails();
    // getTripDataFromHive();
  }

  Future<void> onRefresh() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future getTrips() async{
    List<Map<String, dynamic>>? triplist = await DatabaseService().getTripDetails(uid!);

    //checking mounted to get rid of setState() called after dispose() error.
    
    if(mounted){
    setState(() {
      trips = triplist!;
    });
    }
  }

// void getTripDataFromHive() async {
//   final signupDB = await Hive.box<UserModel>('signup_db');
//   UserModel? user = signupDB.values.last;
//   print('user: ${user.username}');
//   if (user != null) {
//     final tripplist = await getTripDetails();
//     final userlist = user.tripdetailslist;
//     print('UserList: $tripplist');
//     setState(() {
//       trip = userlist;
//     });
//   } else {
//     print('ERROR IN GETTRIPDATAFROMHIVE()');
//     // Handle the case where user is null or doesn't contain tripdetailslist
//   }
//   print('TRIP DATA LIST: $trip');
//   setState(() {});
// }

  @override
  Widget build(BuildContext context) {

  double screenWidth = MediaQuery.sizeOf(context).width;
  double screenHeight = MediaQuery.sizeOf(context).height;
  print('$screenWidth, $screenHeight');

  return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTrip(),
            ),
          );
        },
        bottom: 75,
      ),
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: LiquidPullToRefresh(
        color: Color.fromARGB(255, 190, 255, 0),
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        animSpeedFactor: 2.0,
        springAnimationDurationInMilliseconds: 800,
        onRefresh: onRefresh,
        showChildOpacityTransition: false,
        child: SafeArea(
            child: Stack(children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  // height: ,
                  padding: EdgeInsets.all(screenHeight/53.3), //~=15
                  color: const Color.fromRGBO(21, 24, 43, 1),
                  child: Column(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/wanderloom_logo.png',
                                  height: screenHeight/16,
                                ),
                                 Text(
                                  "Your Trips!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenHeight/26.6,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Icon(
                                  Icons.notifications_active,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight/53.3,
                            ),
                            trips.isNotEmpty ?
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                              Map<String, dynamic> trip = trips[index];
                              String tripId = trip['tripId'];
                              
                              return TripInfo (categoryIcon: 
                              'assets/icons/money-with-wings_emoji_1f4b8.png', categoryName: trip['tripcategory'], tripTitle: trip['tripname'], tripDate: trip['tripdate'], tripBudget: trip['tripbudget'], tripPeople: trip['tripparticipants'], catContWidth: screenHeight/6.5,
                              returnParameter: tripId);
                            } 
                            , separatorBuilder: (context, index) => SizedBox(height: screenHeight/80), itemCount: trips.length) : Container(
                              height: screenHeight/1.4,
                              width: screenWidth,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.airplane_ticket, size: 100,weight: 1,fill: 0.5, color: Color.fromARGB(50, 255, 255, 255),),
                                  Text('Start planning your trip by tapping\n                   on the + button', style: TextStyle(fontSize: 18, color: Color.fromARGB(50, 255, 255, 255),),)
                                ],
                              ),
                            )
                          //   ListView.separated(
                          //   shrinkWrap: true,
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   separatorBuilder: (context, index) => const SizedBox(height: 10),
                          //   itemBuilder: (context, index) {
                          //     final tripData = trip[index];
                          //     return TripInfo(
                          //       categoryIcon: tripData.trippcategoryiconpath,
                          //       categoryName: tripData.trippcategorytitle,
                          //       tripTitle: tripData.tripptitle,
                          //       tripDate: tripData.trippdate,
                          //       tripBudget: tripData.trippbudget,
                          //       tripPeople: tripData.participants,
                          //       catContWidth: 90
                          //     );
                          //   },
                          //   itemCount: trip.length
                          // )
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 16,
          //   left: 23,
          //   child:
          // Container(
          //   padding: EdgeInsets.fromLTRB(20, 10, 20, 12),
          //   height: 60,
          //   width: 350,
          //   decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(35),
          //   color: Color.fromARGB(221, 1, 1, 1), boxShadow:[BoxShadow(color: Color.fromARGB(0, 33, 149, 243), blurRadius: 8,spreadRadius: 0, blurStyle: BlurStyle.outer)] ),
          // child: BottomNavigationBar(items: [BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket_rounded, ), label: 'Trips'), BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'), BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')], backgroundColor: Colors.transparent,),
          //     IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //       return ExplorePage();
          //     }));
          //     }, icon: Icon(Icons.explore, color: Colors.white,)),
          //     IconButton(onPressed: (){}, icon: Icon(Icons.person, color: Colors.white,)),
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
          //     ],
          //   )
          // ),
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
          // )
        ])),
      ),
      // bottomNavigationBar: BottomNav(),
    );
  }
}
