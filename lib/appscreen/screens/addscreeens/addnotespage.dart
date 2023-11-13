import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/notes_page.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class AddNotes extends StatefulWidget {
  AddNotes({required this.tripId, super.key});
  String tripId;
  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  
  TextEditingController notesTitleController = TextEditingController();
  TextEditingController notesDescriptionController = TextEditingController();
  var divider = const SizedBox(height: 10,);
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.white,
                          ),
                          const Text(
                            'Add Notes!',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          ElevatedButton(
                            onPressed: () {
                             onSave();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 190, 255, 0)),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Color.fromRGBO(21, 24, 43, 1),
                              ),
                            ),
                          )
                        ],
                      ),
                      divider,
                      divider,
                      Textfeildtrip(
                        addtripController: notesTitleController,
                        textformlabel: "Add a title",
                        textformhinttext: 'Imp Contacts',
                        textformIconPrefix: Icons.title,
                      ),
                      divider,
                      divider,
                      Textfeildtrip(
                        maxLines: 10,
                        addtripController: notesDescriptionController,
                        textformlabel: "Description",
                        textformhinttext: 'Agra Auto Contact No: ',
                        textformIconPrefix: Icons.description,
                      ),
  ])
              ))
              ));
  }
  onSave() async{
    if(notesTitleController.toString().isNotEmpty && notesDescriptionController.toString().isNotEmpty){

    final notesTitle = notesTitleController.text.toString();
    final notesDescription = notesDescriptionController.text.toString();

    String userId = uid;

    await DatabaseService().savetoNotes(notesTitle, notesDescription, userId, widget.tripId);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return NotesPage(tripId: widget.tripId);
    }));
    
    }
  }
}