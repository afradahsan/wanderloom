import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/additinerary.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/edit_itinerary.dart';
import 'package:wanderloom/appscreen/screens/backpack_page.dart';
import 'package:wanderloom/appscreen/screens/budget_page.dart';
import 'package:wanderloom/appscreen/screens/notes_page.dart';
import 'package:wanderloom/appscreen/screens/reminderpage.dart';
import 'package:wanderloom/appscreen/widgets/floatingbutton.dart';
import 'package:wanderloom/appscreen/widgets/itinerarytime.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class ItineraryPage extends StatefulWidget {
  const ItineraryPage({required this.tripId, this.triptitle, super.key});
  final String tripId;
  final String? triptitle;

  @override
  State<ItineraryPage> createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  final divider = const SizedBox(height: 10,);

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    checkUserConnection();
  }

  Future<void> onRefresh() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> getItineraryFunction() async {
    return await DatabaseService().getItinerary(uid, widget.tripId);
  }

  bool ActiveConnection = true; 
  Future checkUserConnection() async { 
    try { 
    final result = await InternetAddress.lookup('google.com'); 
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { 
      setState(() { 
      ActiveConnection = true; 
      }); 
    } 
    } on SocketException catch (_) { 
    setState(() { 
      ActiveConnection = false; 
    }); 
    }

    if(ActiveConnection==false){
      // ignore: use_build_context_synchronously
      return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("You're Offline!", style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),),),
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("It looks like you're offline.", style: TextStyle(color: Colors.white),),
            Text("Please check your internet connection and try again." ,style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      actions: <Widget>[
          TextButton(
            child: const Text('OK', style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });}
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        appBar: AppBar(
          bottom: const TabBar(
            isScrollable: true,
            enableFeedback: true,
            indicatorColor: Color.fromARGB(255, 190, 255, 0),
            tabs: [
              Tab(icon: Row(children: [Icon(Icons.map_outlined),SizedBox(width: 5,), Text('Itinerary')],),),
              Tab(icon: Row(children: [Icon(Icons.attach_money_rounded),SizedBox(width: 5,), Text('Budget')],),),
              Tab(icon: Row(children: [Icon(Icons.backpack_rounded),SizedBox(width: 5,), Text('Backpack')],),),
              // Tab(icon: Row(children: [Icon(Icons.notifications_none_rounded),SizedBox(width: 5,), Text('Reminder')],),),
              Tab(icon: Row(children: [Icon(Icons.notes),SizedBox(width: 5,), Text('Notes')],),)
          ],
          ),
          title: Text(
            widget.triptitle!,
            style: TextStyle(fontSize: screenHeight/40, color: Color.fromARGB(255, 190, 255, 0)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        // drawer: Sidebar(tripId: widget.tripId,),
        body: TabBarView(
          children: [
            LiquidPullToRefresh(
              color: Color.fromARGB(255, 190, 255, 0),
              backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
              animSpeedFactor: 2.0,
              springAnimationDurationInMilliseconds: 800,
              showChildOpacityTransition: false,
              onRefresh: onRefresh,
              child: Scaffold(
                backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
                floatingActionButton: FloatingButton(
                  bottom: 20,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddItinerary(tripId: widget.tripId),
                      ),
                    );
                  },
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
                      color: const Color.fromRGBO(21, 24, 43, 1),
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: getItineraryFunction(),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              height: screenHeight,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: screenHeight/3,
                                    left: screenWidth/2.5,
                                    child: const CircularProgressIndicator(
                                      color: Color.fromARGB(255, 190, 255, 0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'An ${snapshot.error} occurred',
                              style: TextStyle(fontSize: screenHeight / 44.44, color: Colors.red),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          final itinerary = snapshot.data;
                          final groupedItinerary = groupItineraryByDate(itinerary);
            
                          if (groupedItinerary.isEmpty) {
                            return Container(
                              height: screenHeight/1.3,
                              width: screenWidth,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.route, size: 120,weight: 1,fill: 0.5, color: Color.fromARGB(50, 255, 255, 255),),
                                  Text('Tap on the + to add a new itinerary', style: TextStyle(fontSize: 16, color: Color.fromARGB(50, 255, 255, 255),),)
                                ],
                              ),
                            );
                          }
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return divider;
                              },
                              itemCount: groupedItinerary.keys.length,
                              itemBuilder: (context, index) {
                                final date = groupedItinerary.keys.elementAt(index);
                                final itemsForDate = groupedItinerary[date]!;
                                
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    itinerDate(date),
                                    for (var item in itemsForDate)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context){return EditItinerary(tripTitle: widget.triptitle!,
                                            itnlocationCont: item['location'], itndescriptionCont: item['description'],itnlinkController: item['links'],  tripId: widget.tripId,
                                            itineraryId: item['id'],);
                                            }));
                                        },
                                        child: snapshot.data!= null ? Itinerarytime(
                                          itntime: item['time'],
                                          itnlocation: item['location'],
                                          itndescription: item['description'],
                                          itnLink: item['links'],
                                        ) :
                                        Container(color: Colors.white, height: 100,)
                                      ),
                                  ],
                                );
                              },
                            );
                          }
                          return Container(
                              height: screenHeight/1.3,
                              width: screenWidth,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.wallet, size: 120,weight: 1,fill: 0.5, color: Color.fromARGB(50, 255, 255, 255),),
                                  Text('Tap on the + to add Itinerary', style: TextStyle(fontSize: 16, color: Color.fromARGB(50, 255, 255, 255),),)
                                ],
                              ),
                            );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BudgetPage(tripId: widget.tripId),
            BackpackPage(tripId: widget.tripId),
            // const ReminderPage(),
            NotesPage(tripId: widget.tripId),

          ],
        ),
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> groupItineraryByDate(List<Map<String, dynamic>>? itinerary) {
    final groupedItinerary = <String, List<Map<String, dynamic>>>{};

    if (itinerary != null) {
      for (var item in itinerary) {
        final date = item['date'] as String;
        if (groupedItinerary.containsKey(date)) {
          groupedItinerary[date]!.add(item);
        } else {
          groupedItinerary[date] = [item];
        }
      }
    }

    // Sort keys (dates) in ascending order
    final sortedKeys = groupedItinerary.keys.toList()
      ..sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));

    // Create a new map with sorted keys
    final sortedItinerary = <String, List<Map<String, dynamic>>>{};
    for (var key in sortedKeys) {
      sortedItinerary[key] = groupedItinerary[key]!;
    }

    return sortedItinerary;
  }

  Widget itinerDate(itinDate) {
    DateTime date = DateTime.parse(itinDate);
  String formattedDate = DateFormat('MMM d').format(date);
    return Text(
      formattedDate,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        decoration: TextDecoration.underline,
        decorationThickness: 2,
        decorationColor: Color.fromARGB(255, 190, 255, 0),
      ),
    );
  }
}
