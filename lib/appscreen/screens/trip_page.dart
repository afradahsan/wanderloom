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
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future getTrips() async {
    List<Map<String, dynamic>>? triplist =
        await DatabaseService().getTripDetails(uid!);

    //checking mounted to get rid of setState() called after dispose() error.

    if (mounted) {
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
                  padding: EdgeInsets.all(screenHeight / 53.3), //~=15
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
                                  height: screenHeight / 16,
                                ),
                                Text(
                                  "Your Trips!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenHeight / 26.6,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Icon(
                                  Icons.notifications_active,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight / 53.3,
                            ),
                            trips.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> trip = trips[index];
                                      String tripId = trip['tripId'];

                                      return TripInfo(
                                          categoryIcon:
                                              'assets/icons/money-with-wings_emoji_1f4b8.png',
                                          categoryName: trip['tripcategory'],
                                          tripTitle: trip['tripname'],
                                          tripDate: trip['tripdate'],
                                          tripBudget: trip['tripbudget'],
                                          tripPeople: trip['tripparticipants'],
                                          catContWidth: screenHeight / 6.5,
                                          returnParameter: tripId);
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: screenHeight / 80),
                                    itemCount: trips.length)
                                : Container(
                                    height: screenHeight / 1.4,
                                    width: screenWidth,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.airplane_ticket,
                                          size: 100,
                                          weight: 1,
                                          fill: 0.5,
                                          color:
                                              Color.fromARGB(50, 255, 255, 255),
                                        ),
                                        Text(
                                          'Start planning your trip by tapping\n                   on the + button',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                50, 255, 255, 255),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
        ])),
      ),
    );
  }
}
