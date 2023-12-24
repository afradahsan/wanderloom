import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/datetimepickerwidget.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/delete_editcontainer.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class EditTrip extends StatefulWidget {
  const EditTrip({required this.triptitle, required this.budget,required this.tripcategory, super.key});

  final String triptitle;
  final String budget;
  final String tripcategory;

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {

  var divider = const SizedBox(height: 10);
  final _formKey = GlobalKey<FormState>();
  late TextEditingController triptitleController;
  late TextEditingController budgetController;
  late TextEditingController categoryController;

  bool isDeleting = false; // Add a boolean flag to control deletion
  bool submitted = false;

  String? uid = FirebaseAuth.instance.currentUser!.uid;
  String? selectedDate;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
      triptitleController = TextEditingController(text: widget.triptitle);
    budgetController = TextEditingController(text: widget.budget);
    categoryController = TextEditingController(text: widget.tripcategory);
  }
  
  @override
  Widget build(BuildContext context) {
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
                        'Update Trip',
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
                    addtripController: triptitleController,
                    submitted: submitted,
                    textformlabel: 'Trip Title',
                    textformhinttext: 'Give your trip a name!',
                    textformIconPrefix: Icons.near_me,
                    inputType: TextInputType.text,
                  ),
                  divider,divider,
                  Textfeildtrip(
                    addtripController: budgetController,
                    textformlabel: 'Budget',
                    textformhinttext: 'Expecting Budget?',
                    textformIconPrefix: Icons.currency_rupee,
                    submitted: submitted,
                    inputType: TextInputType.number,
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
                  
                  divider,divider,divider,

                  if (!isDeleting) // Show DeleteContainer only if not deleting
                    DeleteContainer(
                      // Pass the callback function and update the flag
                      callbackFunction: () {
                        setState(() {
                          isDeleting = true; // Set the flag to indicate deletion
                        });
                        DatabaseService().deleteNotes(
                          uid!,
                          widget.tr,
                        ).then((_) {
                          setState(() {
                            isDeleting = false; // Reset the flag after deletion
                          });
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: ((context) {
                                return ItineraryPage(tripId: widget.tripId);
                              }),
                            ),
                          );
                        }
                      );
                    },
                  ),
                ]
              )
            )
          )
        )
      )
    );
  }

  Future<void> onUpdate() async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final tripname = triptitleController.text.trim();
      final tripbudget = budgetController.text.trim();
      // final tripdate = formattedDate;

      print(_selectedIndex);

      if (_selectedIndex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category'), duration: Duration(seconds: 2),
        ),
      );
      return; // Exit the function without saving to Firebase
    }

    final tripcategory = _choiceChipsList[_selectedIndex!].label;
    final tripparticipants = _currentValue.toString();

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