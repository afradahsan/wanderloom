// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wanderloom/appscreen/screens/trip_page.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/daterangewidget.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/auth/functions/auth_functions.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({super.key});

  @override
  State<AddTrip> createState() => _AddTripState();
}

class Data {
  String label;
  String avatar;

  Data(this.label, this.avatar);
}

class _AddTripState extends State<AddTrip> {
  AuthService authService = AuthService();
  int _currentValue = 1;
  String? uid = FirebaseAuth.instance.currentUser!.uid;


  final List _choiceChipsList = [
    Data('Family', 'assets/icons/family_icon_blackc.png'),
    Data('Adventure', 'assets/images/adventure_blackicon.png'),
    Data('Friends', 'assets/icons/friends_black_icon.png'),
    Data('Business', 'assets/icons/business_icon_black.png'),
    Data('Leisure', 'assets/icons/education_trip_blackicon.png'),
    Data('Edu Trips', 'assets/icons/education_trip_blackicon.png'),
    Data('Piligrimage', 'assets/icons/pray_emoji.png'),
    Data('Others', 'assets/icons/friends_black_icon.png')
  ];

  int? _selectedIndex;

  var divider = const SizedBox(height: 10);
  final _formKey = GlobalKey<FormState>();

  final _triptitlecontroller = TextEditingController();
  final _tripbudgetcontroller = TextEditingController();
  // DateTimeRange? _selectedDateRange;
  String? categorylabel;
  Image? categoryicon;

  // String? getCurrentUserId(){
  //   final user = FirebaseAuth.instance.currentUser;
  //   if(user!=null){
  //     return user.uid;
  //   }
  //   else{
  //     return null;
  //   }
  // }
  @override
  void initState() {
    super.initState();
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
                        'Create Trip',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onSave(context);
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
                    addtripController: _triptitlecontroller,
                    textformlabel: 'Trip Title',
                    textformhinttext: 'Give your trip a name!',
                    textformIconPrefix: Icons.near_me,
                  ),
                  divider,
                  divider,
                  Textfeildtrip(
                    addtripController: _tripbudgetcontroller,
                    textformlabel: 'Budget',
                    textformhinttext: 'Expecting Budget?',
                    textformIconPrefix: Icons.currency_rupee,
                    inputType: TextInputType.number,
                  ),
                  divider,
                  divider,
                  const DateRangePicker(),
                  divider,
                  const Text(
                    'Choose Category',
                    style: TextStyle(
                        color: Color.fromARGB(255, 190, 255, 0), fontSize: 16),
                  ),
                  Wrap(children: choiceChips()),
                  divider,
                  const Text(
                    'No. of People',
                    style: TextStyle(
                        color: Color.fromARGB(255, 190, 255, 0), fontSize: 16),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _showDialog(_currentValue);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          side: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 190, 255, 0),
                          )),
                      child: Text('$_currentValue')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showDialog(currentValue) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
          title: const Text(
            'Choose no.',
            style: TextStyle(color: Colors.white),
          ),
          content: StatefulBuilder(builder: (context, setStateNump) {
            // stateful builder used when we want to change the dialog's appearance based on user interaction.
            return NumberPicker(
              minValue: 1,
              maxValue: 100,
              haptics: true,
              textStyle: const TextStyle(color: Colors.white),
              selectedTextStyle: const TextStyle(
                color: Color.fromARGB(255, 190, 255, 0),
              ),
              value: _currentValue,
              onChanged: (value) {
                print('Selected value: $value');
                setState(() {
                  _currentValue = value;
                  print(
                      'value changed to $currentValue'); // Update the selected value
                });
                setStateNump(() {}); //to change on dialog state
              },
            );  
          }),
          actions: [
            TextButton(
              onPressed: () {
                print('Close button pressed');
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color.fromARGB(255, 190, 255, 0),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                print('Save button pressed. Current value: $_currentValue');
                Navigator.pop(context);
              },
              child: const Text('Save',
                  style: TextStyle(
                    color: Color.fromARGB(255, 190, 255, 0),
                  )),
            ),
          ],
        );
      },
    );
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          labelPadding: const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.all(8),
          label: Text(_choiceChipsList[i].label),
          labelStyle: const TextStyle(color: Colors.black),
          avatar: Image.asset(_choiceChipsList[i].avatar),
          // visualDensity: VisualDensity(horizontal: 3, vertical: 0.5),
          // showCheckmark: true,
          selected: _selectedIndex == i,
          selectedColor: const Color.fromARGB(255, 190, 255, 0),
          backgroundColor: Colors.transparent,
          onSelected: (bool value) {
            setState(() {
              _selectedIndex = i;
              final categorylabel = _choiceChipsList[_selectedIndex!].label;
              final categoryicon = _choiceChipsList[_selectedIndex!].avatar;
              print('Category label: $categorylabel');
              print('Category icon: $categoryicon');
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  Future<void> onSave(context) async {

    final tripname = _triptitlecontroller.text.trim();
    final tripbudget = _tripbudgetcontroller.text.trim();
    final tripdate = formattedDate;
    final tripcategory = _choiceChipsList[_selectedIndex!].label;
    final tripparticipants = _currentValue.toString();



    DatabaseService().saveTripData(tripname, tripbudget, tripdate, tripcategory, tripparticipants, uid);

     Navigator.of(context).pop();

    
    // if (_selectedIndex == null) {
    //   print('THE VALUE IS NULL');
    //   // will print the case when no category is selected
    //   return;
    // }

    // // final title = _triptitlecontroller.text.trim();
    // final budget = _tripbudgetcontroller.text.trim();
    // final categorylabel = _choiceChipsList[_selectedIndex!].label;
    // final categoryicon = _choiceChipsList[_selectedIndex!].avatar;
    // final noofppl = _currentValue.toString();
    // final trippdate = formattedDate;

    // if (title.isEmpty || budget.isEmpty) {
    //   print('TITLE/BUDGET EMPTY');
    //   return;
    // } else {
    //   print('INITIALL PRINTTT!!: $title, $budget,$categorylabel,$categoryicon $noofppl, $trippdate');

    //   // final dtrange = _selectedDateRange!.toString();
    //   final tripp = TripDetailsModel(
          
    //       tripptitle: title,
    //       trippbudget: budget,
    //       trippcategorytitle: categorylabel,
    //       trippcategoryiconpath: categoryicon,
    //       participants: noofppl,
          // trippdate: formattedDate;
    //       );
      
    //     addTripDetails(tripp);

    //   print('YO PRINT THISSS: $title, $budget,$categorylabel,$categoryicon, $noofppl');

    //  
    //   print('blahh');
  }
}