// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/addbudgetpage.dart';
import 'package:wanderloom/appscreen/widgets/floatingbutton.dart';
import 'package:wanderloom/appscreen/widgets/side_menubar.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {

  var divider = const SizedBox(height: 10,);
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  String? tripId;

  @override
  void initState() {
    super.initState();
    fetchTripId();
  }

  Future<void> fetchTripId() async {
    tripId = await DatabaseService().getTripIdForUser(uid!);
    setState(() {
    });
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
        actions: const [Icon(Icons.arrow_back)],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingButton(
        onPressed: () {
          print('tripiddd: $tripId');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddBudgetPage(tripId: tripId),              
            ),
          );
        },
      ),
      drawer: const Sidebar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(
                 padding: const EdgeInsets.all(15),
                 width: 370,
                 height: 147,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   color: const Color.fromARGB(51, 255, 255, 255),
                   boxShadow: const [BoxShadow(color: Color.fromARGB(30, 0, 0, 0), blurRadius: 30,spreadRadius: 25, offset: Offset(8, 8))]
                 ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TOTAL EXPENSE', style: TextStyle(fontSize: 22, color: Color.fromARGB(175, 255, 255, 255)),),
                  SizedBox(height: 5,),
                  Text('₹45300', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26, color: Color.fromARGB(255, 190, 255, 0))),
                  Text('Out of {₹72,000}', style: TextStyle(fontSize: 16, color: Color.fromARGB(215, 255, 255, 255)),),
                  SizedBox(height: 5,),
                  Text('27.9% of the Budget Already used.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromARGB(215, 255, 255, 255)),)
                ],
              ),
            ),
            divider,
            const Text('8th Dec', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Color.fromARGB(255, 190, 255, 0))),
            divider,
            expensetile(Icons.local_taxi, 'Cab to Jaigarh Fort', '₹600'),
            divider,
            divider,
            expensetile(Icons.restaurant, 'Snacks', '₹130'),
            divider,
            divider,
            expensetile(Icons.paragliding, 'Activities', '₹1500'),
            divider,
            divider,
            expensetile(Icons.hotel, 'Resort Stay', '₹1300'),
            divider,
            divider,
            expensetile(Icons.shopping_bag, 'Shopping', '₹1500'),           

              ],
            ),
          ),
        )
        ),
    );
  }
  expensetile(IconData expenseCategoryIcon, String expenseTitle, String expense){
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
                   boxShadow: const [BoxShadow(color: Color.fromARGB(30, 0, 0, 0),)]
                 ),
                 child: Icon(expenseCategoryIcon, color: const Color.fromARGB(255, 190, 255, 0),size: 16)
            ),
            const SizedBox(width: 10,),
            Text(expenseTitle, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromARGB(255, 255, 255, 255))),
          ],
        ),
        Container(alignment: Alignment.center, height: 25,width: 43,
        decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.rectangle,border: Border.all(color: const Color.fromARGB(255, 190, 255, 0), width: 1), borderRadius: BorderRadius.circular(8)), child: Text(expense, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color.fromARGB(255, 255, 255, 255)))),
              ],
            );
  }
}