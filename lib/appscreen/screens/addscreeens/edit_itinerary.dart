import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/itinerary_page.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/datetimepickerwidget.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/delete_editcontainer.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/appscreen/widgets/delete_dialog.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class EditItinerary extends StatefulWidget {
  const EditItinerary({required this.itnlocationCont,required this.itndescriptionCont, this.itnlinkController, required this.tripId, this.tripTitle,required this.itineraryId, super.key});

  final String tripId;
  final String itnlocationCont;
  final String itndescriptionCont;
  final String? itnlinkController;
  final String? tripTitle;
  final String itineraryId;

  @override
  State<EditItinerary> createState() => _EditItineraryState();
}

class _EditItineraryState extends State<EditItinerary> {
  var divider = const SizedBox(height: 10);
  final _formKey = GlobalKey<FormState>();
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController linkController;

  String? uid = FirebaseAuth.instance.currentUser!.uid;
  String? selectedDate;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
      locationController = TextEditingController(text: widget.itnlocationCont);
    descriptionController = TextEditingController(text: widget.itndescriptionCont);
    linkController = TextEditingController(text: widget.itnlinkController ?? '');
  }
  
  @override
  Widget build(BuildContext context) {

    print('itineray id: ${widget.itineraryId}');

    return Scaffold(
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
                        'Update Itinerary',
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
                    inputType: TextInputType.url,
                  ),

                  divider,divider,divider,

                  DeleteContainer(callbackFunction: DatabaseService().deleteItinerary(uid!, widget.tripId, widget.itineraryId))
                ]
              )
            )
          )
        )
      )
    );
  }
    Future<void> onUpdate() async {
    final ItnLocation = locationController.text.toString();
    final ItnDescription = descriptionController.text.toString();
    final ItnLinks = linkController.text.toString();
    final userId = uid;

    if(selectedDate == null && selectedTime == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Update Date & Time')));
    }

    if (selectedDate != null && selectedTime != null && ItnLocation.isNotEmpty && ItnDescription.isNotEmpty) {

      final tripid = widget.tripId;
      print('bla bla black');

      // Now you can proceed to save the data.
      DatabaseService().updateItinerary(
        widget.itineraryId,
        ItnLocation,
        selectedDate!,
        selectedTime!,
        ItnDescription,
        ItnLinks,
        userId,
        tripid
      );

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return ItineraryPage(tripId: widget.tripId, triptitle: widget.tripTitle,);
    }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error Updating Itinerary')));
    }
  }
}