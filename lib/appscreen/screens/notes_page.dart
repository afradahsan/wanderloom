// ignore_for_file: unused_import, avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/addnotespage.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/editnotes.dart';
import 'package:wanderloom/appscreen/widgets/floatingbutton.dart';
import 'package:wanderloom/appscreen/widgets/side_menubar.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class NotesPage extends StatefulWidget {
  NotesPage({required this.tripId, super.key});

  String tripId;

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future getNotesFunction() async {
    final getData = await DatabaseService().getNotes(uid, widget.tripId);

    return getData;
  }

  @override
  void initState() {
    super.initState();
    getNotesFunction();
  }

  Future<void> onRefresh() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      // appBar: AppBar(
      //   title: const Text(
      //     'Notes',
      //     style: TextStyle(color: Color.fromARGB(255, 190, 255, 0)),
      //   ),
      //   // actions: const [Icon(Icons.arrow_back)],
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      floatingActionButton: FloatingButton(
        bottom: 20,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNotes(
                tripId: widget.tripId,
              ),
            ),
          );
        },
      ),
      // drawer: Sidebar(
      //   tripId: widget.tripId,
      // ),
      body: LiquidPullToRefresh(
        color: Color.fromARGB(255, 190, 255, 0),
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        animSpeedFactor: 2.0,
        springAnimationDurationInMilliseconds: 800,
        showChildOpacityTransition: false,
        onRefresh: onRefresh,
        child: SafeArea(
          child: SingleChildScrollView(
              child: FutureBuilder(
                  future: getNotesFunction(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 190, 255, 0),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'An ${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      print('snapshot has data');
                      final notes = snapshot.data;
                      print('NOTESSS: $notes');
      
                      if (notes.isEmpty) {
                            return Container(
                              height: screenHeight/1.3,
                              width: screenWidth,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.notes, size: 120,weight: 1,fill: 0.5, color: Color.fromARGB(50, 255, 255, 255),),
                                  Text('Tap on the + to add Notes', style: TextStyle(fontSize: 16, color: Color.fromARGB(50, 255, 255, 255),),)
                                ],
                              ),
                            );
                          }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: notes.length,
                          // separatorBuilder: (context, index) {
                          //   return const SizedBox(height: 10,);
                          // },
                          itemBuilder: (context, index) {
                            final notesmap = notes[index];
                            print("notesmap: $notesmap");
                            return Column(children: [
                              SizedBox(
                                height: screenHeight/80,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return EditNotes(
                                          notestitle: notesmap['Notes title'],
                                          notesdesc:
                                          notesmap['Notes description'],
                                          tripId: widget.tripId,
                                          notesId: notesmap['id'],
                                        );
                                      }));
                                      print('notesid: ${notesmap['id']}');
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(15),
                                        width: screenWidth,
                                        height: screenHeight/8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.2),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color:
                                                      Color.fromARGB(30, 0, 0, 0),
                                                  blurRadius: 30,
                                                  spreadRadius: 25,
                                                  offset: Offset(8, 8))
                                            ]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(notesmap['Notes title'],
                                                style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),fontSize:screenHeight/40,)),
                                            const SizedBox(height: 5),
                                            Text(notesmap['Notes description'],
                                                style: TextStyle(color: Colors.white,fontSize:screenHeight/66.66,)),
                                          ],
                                        )),
                                  ))
                            ]);
                          });
                    }
                    return const Center(child: CircularProgressIndicator());
                  })),
        ),
      ),
    );
  }
}
