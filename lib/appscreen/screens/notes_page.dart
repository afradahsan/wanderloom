import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/addnotespage.dart';
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

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
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
                            SizedBox(height: 10,),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20),
                                child: Container(
                                    padding: const EdgeInsets.all(15),
                                    width: 370,
                                    height: 100,
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
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 190, 255, 0),
                                                fontSize: 20)),
                                        const SizedBox(height: 5),
                                        Text(notesmap['Notes description'],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12)),
                                      ],
                                    )))
                          ]);
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                })),
      ),
    );
  }
}
