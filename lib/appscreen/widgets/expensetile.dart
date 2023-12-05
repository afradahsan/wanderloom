import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/editbudget.dart';

class Expensetile extends StatelessWidget {
   Expensetile({required this.expenseCategoryIcon, required this.expenseTitle, required this.expense, required this.budgetId, required this.tripID, super.key});

  final String expenseCategoryIcon;
  final String expenseTitle;
  final int expense;
  final String budgetId;
  final String tripID;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return EditBudget(
              tripId: tripID,
              budgetId: budgetId,
              expenseTitle: expenseTitle,
              expense: expense);
        }));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: screenHeight/26.66,
                      width: screenHeight/22.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromARGB(51, 255, 255, 255),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(30, 0, 0, 0),
                            )
                          ]),
                      child: Icon(Icons.local_taxi,
                          color: Color.fromARGB(255, 190, 255, 0), size: screenHeight/50)),
                  SizedBox(
                    width: screenHeight/80,
                  ),
                  Text(expenseTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: screenHeight/57.14,
                          color: Color.fromARGB(255, 255, 255, 255))),
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  height: screenHeight/32,
                  width: screenHeight/18.6,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color: const Color.fromARGB(255, 190, 255, 0),
                          width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('₹${expense.toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: screenHeight/66.66,
                          color: Color.fromARGB(255, 255, 255, 255)))),
            ],
          ),
          SizedBox(
            height: screenHeight/80,
          )
        ],
      ),
    );
  }
}