// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/addbudgetpage.dart';
import 'package:wanderloom/appscreen/widgets/floatingbutton.dart';
import 'package:wanderloom/appscreen/widgets/side_menubar.dart';
import 'package:wanderloom/db/functions/database_services.dart';

// ignore: must_be_immutable
class BudgetPage extends StatefulWidget {
  BudgetPage({required this.tripId, super.key});

  String tripId;

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  var divider = const SizedBox(
    height: 10,
  );
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String? tripBudget = '';
  double totalExpenses = 0.0;

  Future<void> fetchTripBudget() async {
    String tripbudget =
        await DatabaseService().getBudget(uid, widget.tripId) ?? 'N/A';
    setState(() {
      tripBudget = tripbudget;
    });
  }

  Future<List<Map<String, dynamic>>> getExpenseFunction() async {
    // ignore: unnecessary_null_comparison
    if (widget.tripId == null) {
      print('tripID IS NULL!'); // Handle the case where tripId is null
      return <Map<String, dynamic>>[];
    }
    print('tripid is $widget.tripId');
    return await DatabaseService().getExpense(uid, widget.tripId);
  }

  @override
  void initState() {
    super.initState();
    fetchTripBudget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        appBar: AppBar(
          title: const Text(
            'Budget',
            style: TextStyle(color: Color.fromARGB(255, 190, 255, 0)),
          ),
          // actions: const [Icon(Icons.arrow_back)],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: FloatingButton(
          onPressed: () {
            print('tripiddd: $widget.tripId');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddBudgetPage(tripId: widget.tripId),
              ),
            );
          },
        ),
        drawer: Sidebar(
          tripId: widget.tripId,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: getExpenseFunction(),
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
                            style: const TextStyle(
                                fontSize: 18, color: Colors.red),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        print('snapshot has data');
                        final expense = snapshot.data;
                        print("expense: $expense");
                        final groupedExpense =  groupExpenseByDate(expense);
                        String? tripbdg = tripBudget;
                        print("tripbdg: $tripbdg");
                        totalExpenses = calculateTotalExpenses(expense);

                        return budgetContainer(
                            expense, groupedExpense, tripbdg!);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }))));
  }

  budgetContainer(List<Map<String, dynamic>>? exp,
      Map<String, List<Map<String, dynamic>>> grpexp, String tripbdg) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(15),
                  width: 370,
                  height: 147,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(51, 255, 255, 255),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(30, 0, 0, 0),
                            blurRadius: 30,
                            spreadRadius: 25,
                            offset: Offset(8, 8))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TOTAL EXPENSE',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(175, 255, 255, 255)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('₹${totalExpenses.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                              color: Color.fromARGB(255, 190, 255, 0))),
                      Text(
                        'Out of $tripbdg',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(215, 255, 255, 255)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${(totalExpenses/int.parse(tripbdg))*100}% of the Budget Already used.',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color.fromARGB(215, 255, 255, 255)),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: grpexp.keys.length,
            itemBuilder: (BuildContext context, index) {
              final date = grpexp.keys.elementAt(index);
              final itemsForDate = grpexp[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itinerDate(date),
                  divider,
                  for (var item in itemsForDate)
                    expensetile(item['expense category'], item['expense title'],
                        item['expense']),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return divider;
            },
          ),
        ),
      ],
    );
  }

  expensetile(String expenseCategoryIcon, String expenseTitle, int expense) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                height: 30,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(51, 255, 255, 255),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(30, 0, 0, 0),
                      )
                    ]),
                child: const Icon(Icons.local_taxi,
                    color: Color.fromARGB(255, 190, 255, 0), size: 16)),
            const SizedBox(
              width: 10,
            ),
            Text(expenseTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromARGB(255, 255, 255, 255))),
          ],
        ),
        Container(
            alignment: Alignment.center,
            height: 25,
            width: 43,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                border: Border.all(
                    color: const Color.fromARGB(255, 190, 255, 0), width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: Text('₹${expense.toString()}',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color.fromARGB(255, 255, 255, 255)))),
      ],
    );
  }

  Map<String, List<Map<String, dynamic>>> groupExpenseByDate(
      List<Map<String, dynamic>>? expenselst) {
    print("expenselst: $expenselst");
    final groupedExpense = <String, List<Map<String, dynamic>>>{};
    if (expenselst != null) {
      for (var item in expenselst) {
        print('dateprint1: ${item['expense date']}');
                print('dateprint2: ${item['expense date']}');

        final date = item['expense date'] as String;
        if (groupedExpense.containsKey(date)) {
          groupedExpense[date]!.add(item);
        } else {
          groupedExpense[date] = [item];
        }
      }
    }
    return groupedExpense;
  }

  Widget itinerDate(itinDate) {
    DateTime date = DateTime.parse(itinDate);
    String formattedDate = DateFormat('MMM d').format(date);
    return Text(
      formattedDate,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        decoration: TextDecoration.underline,
        decorationThickness: 2,
        decorationColor: Color.fromARGB(255, 190, 255, 0),
      ),
    );
  }

  double calculateTotalExpenses(List<Map<String, dynamic>>? expenses) {
    double total = 0.0;
    if (expenses != null) {
      for (var item in expenses) {
        total += item['expense'] ?? 0.0;
      }
    }
    return total;
  }
}
