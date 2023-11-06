// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/itinerary_page.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/datetimepickerwidget.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/db/functions/database_services.dart';


// ignore: must_be_immutable
class AddItinerary extends StatefulWidget {
  AddItinerary({required this.tripId, super.key});
  String tripId;
  @override
  State<AddItinerary> createState() => _AddItineraryState();
}

class _AddItineraryState extends State<AddItinerary> {
  var divider = const SizedBox(height: 10);
  final _formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();

  String? uid = FirebaseAuth.instance.currentUser!.uid;
  String? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Form(
              key: _formKey,
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
                        'Create Itinerary',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onCreate();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 190, 255, 0)),
                        child: const Text(
                          'Create',
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
                    addtripController: locationController,
                    textformlabel: 'Location',
                    textformhinttext: 'Where is the destination?',
                    textformIconPrefix: Icons.location_on,
                  ),
                  divider,
                  const SizedBox(height: 5,),

                  DatetimePicker(
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date.toLocal().toString(); // Convert to a suitable format
                      });
                    },
                    onTimeSelected: (time) {
                      setState(() {
                        selectedTime = time.toString();
                      });
                      
                    },
                  ),


                  const SizedBox(height: 5,),
                  divider,
                  Textfeildtrip(
                    addtripController: descriptionController,
                    textformlabel: 'Description',
                    textformhinttext: 'What are you gonna do there?',
                    textformIconPrefix: Icons.description,
                    inputType: TextInputType.text,
                  ),
                  divider,divider,
                  Textfeildtrip(
                    addtripController: linkController,
                    textformlabel: 'Links/Notes (optional)',
                    textformhinttext: 'Any reference links/notes?',
                    textformIconPrefix: Icons.link,
                    inputType: TextInputType.text,
                  ),

                  divider,divider,divider,

                  // const Column(
                  //   children: [
                  //     Text("What's Itinerary?", style: TextStyle(fontSize: 24, color:  Color.fromARGB(122, 255, 255, 255)),),
                  //     Text("Wondering what itinerary is? An itinerary is a schedule or plan that lists activities, events, and their order, helping organize and guide a trip.", style: TextStyle(fontSize: 14, color:  Color.fromARGB(122, 255, 255, 255)),),
                  //   ],
                  // )
                ]
              )
            )
          )
        )
      )
    );
  }

  Future<void> onCreate() async {
    final ItnLocation = locationController.text.toString();
    final userId = uid;


    if (selectedDate != null && selectedTime != null) {
      final ItnDescription = descriptionController.text.toString();
      final ItnLinks = linkController.text.toString();

      final tripid = widget.tripId;

      // Now you can proceed to save the data.
      DatabaseService().saveItinerary(
        ItnLocation,
        selectedDate!,
        selectedTime!,
        ItnDescription,
        ItnLinks,
        userId,
        tripid
      );
    } else {
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return ItineraryPage(tripId: widget.tripId);
    }));
  }
}

