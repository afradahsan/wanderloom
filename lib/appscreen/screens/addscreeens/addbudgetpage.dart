// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/budget_page.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/datepicker.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/db/functions/database_services.dart';

// ignore: must_be_immutable
class AddBudgetPage extends StatefulWidget {
  AddBudgetPage({required this.tripId, super.key});

  String? tripId;

  @override
  State<AddBudgetPage> createState() => _AddBudgetPageState();
}

class Data {
  String label;
  IconData icon;

  Data(this.label, this.icon);
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  final List _choiceChipsList = [
    Data('Food & Drinks', Icons.restaurant),
    Data('Transportation', Icons.local_taxi),
    Data('Accomodation', Icons.hotel),
    Data('Fuel', Icons.local_gas_station_rounded),
    Data('Shopping', Icons.shopping_bag),
    Data('Activities', Icons.paragliding_rounded),
    Data('Others', Icons.apps_rounded)
  ];

  int? _selectedIndex;

  var divider = const SizedBox(
    height: 10,
  );
  TextEditingController expenseController = TextEditingController();
  TextEditingController expenseTitleController = TextEditingController();
  String? selectedDate;
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    'Add Expense',
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
                addtripController: expenseTitleController,
                textformlabel: 'Budget Title',
                textformhinttext: 'Cab to Taj Mahal',
                textformIconPrefix: Icons.money_rounded,
              ),
              divider,
              const SizedBox(
                height: 5,
              ),
              DatePicker(onDateSelected: (date) {
                setState(() {
                  selectedDate = date.toLocal().toString();
                });
              }),
              divider,
              const Text(
                'Choose Category',
                style: TextStyle(
                    color: Color.fromARGB(255, 190, 255, 0), fontSize: 16),
              ),
              Wrap(children: choiceChips()),
              divider,
              divider,
              Textfeildtrip(
                addtripController: expenseController,
                textformlabel: 'Expense',
                textformhinttext: '1500',
                textformIconPrefix: Icons.currency_rupee,
                inputType: TextInputType.number,
              ),
            ]),
          )),
        ));
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
          labelStyle: const TextStyle(color: Color.fromRGBO(21, 24, 43, 1)),
          avatar: Icon(
            _choiceChipsList[i].icon,
            size: 18,
          ),
          // visualDensity: VisualDensity(horizontal: 3, vertical: 0.5),
          // showCheckmark: true,
          selected: _selectedIndex == i,
          selectedColor: const Color.fromARGB(255, 190, 255, 0),
          backgroundColor: Colors.transparent,
          onSelected: (bool value) {
            setState(() {
              _selectedIndex = i;
              final categorylabel = _choiceChipsList[_selectedIndex!].label;
              final categoryicon = _choiceChipsList[_selectedIndex!].icon;
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

  Future onSave() async {
    final expenseTitle = expenseTitleController.text.toString();
    final expenseCategory = _choiceChipsList[_selectedIndex!].label;
    final int expense = int.parse(expenseController.text);
    final expenseDate = selectedDate;

    final userId = uid!;
    final tripId = widget.tripId;

    databaseService.saveExpense(
        expenseTitle, expenseCategory, expense, expenseDate, userId, tripId!);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return BudgetPage(tripId: tripId);
    }));
  }
}
