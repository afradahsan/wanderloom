import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/budget_page.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/datepicker.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/delete_editcontainer.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class EditBudget extends StatefulWidget {
  const EditBudget({required this.tripId,required this.budgetId,required this.expenseTitle, required this.expense, super.key});

  final String? tripId;
  final String? budgetId;
  final int? expense;
  final String? expenseTitle;

  @override
  State<EditBudget> createState() => _EditBudgetState();
}

class Data {
  String label;
  IconData icon;

  Data(this.label, this.icon);
}

class _EditBudgetState extends State<EditBudget> {

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

      bool isDeleting = false; // Add a boolean flag to control deletion


  var divider = const SizedBox(
    height: 10,
  );

  late TextEditingController expenseController;
  late TextEditingController expenseTitleController;
  String? selectedDate;
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenseController = TextEditingController(text: widget.expense.toString());
    expenseTitleController = TextEditingController(text: widget.expenseTitle);
  }
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
                    'Edit Expense',
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
              divider,divider,
              
if (!isDeleting) // Show DeleteContainer only if not deleting
                    DeleteContainer(
                      // Pass the callback function and update the flag
                      callbackFunction: () {
                        setState(() {
                          isDeleting = true; // Set the flag to indicate deletion
                        });
                        DatabaseService().deleteNotes(
                          uid!,
                          widget.tripId!,
                          widget.budgetId!,
                        ).then((_) {
                          setState(() {
                            isDeleting = false; // Reset the flag after deletion
                          });
                          Navigator.of(context).pop();
                        });
                      },
                    ),            ]),
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

  Future onUpdate() async {
    final expenseTitle = expenseTitleController.text.toString();
    final expenseCategory = _choiceChipsList[_selectedIndex!].label;
    final int expense = int.parse(expenseController.text);
    final expenseDate = selectedDate;

    final userId = uid!;
    final tripId = widget.tripId;

    if(expenseTitle.isNotEmpty && expenseCategory!=null && expense!=null && expenseDate!.isNotEmpty){

    databaseService.updateExpense(expenseTitle, expenseCategory, expense, expenseDate, userId, tripId!, widget.budgetId!);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return BudgetPage(tripId: tripId);
    }));
  }
  }
}