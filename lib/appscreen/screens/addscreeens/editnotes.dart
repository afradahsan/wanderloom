import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/notes_page.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/delete_editcontainer.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class EditNotes extends StatefulWidget {
  EditNotes({required this.notestitle, required this.notesdesc, required this.tripId,required this.notesId, super.key});

  var notestitle;
  var notesdesc;
  String tripId;
  String notesId;

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {

  var divider = const SizedBox(height: 10,);
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController? notesTitleController;
  TextEditingController? notesDescriptionController;

  @override
  Widget build(BuildContext context) {
    
    notesTitleController = TextEditingController(text: widget.notestitle);
    notesDescriptionController = TextEditingController(text: widget.notesdesc);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                      'Update Note',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    
                    ElevatedButton(
                      onPressed: () {
                        onUpdate();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 190, 255, 0)),
                      child: const Text(
                        'Update',
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
                  textformlabel: 'Note title',
                  textformhinttext: 'Where is the destination?',
                  textformIconPrefix: Icons.location_on,
                ),
                divider,
                const SizedBox(height: 5,),
                Textfeildtrip(
                  addtripController: notesDescriptionController,
                  textformlabel: 'Description',
                  textformhinttext: '',
                  textformIconPrefix: Icons.description,
                  inputType: TextInputType.text,
                ),
                divider,divider,
                DeleteContainer(callbackFunction: DatabaseService().deleteNotes(uid!, widget.tripId, widget.notesId))
              ]
            )
          )
        )
      )
    );
  }

  void onUpdate(){
    if(notesTitleController!=null && notesDescriptionController!=null){
    DatabaseService().updateNotes(notesTitleController!.text.toString(),notesDescriptionController!.text.toString(), uid!, widget.tripId, widget.notesId);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) {
      return NotesPage(tripId: widget.tripId);
    })));
    }
  }
}