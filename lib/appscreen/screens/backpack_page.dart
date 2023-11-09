import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/addto_backpackpage.dart';
import 'package:wanderloom/appscreen/widgets/floatingbutton.dart';
import 'package:wanderloom/appscreen/widgets/side_menubar.dart';

class BackpackPage extends StatefulWidget {
  BackpackPage({required this.tripId, super.key});
  String tripId;

  @override
  State<BackpackPage> createState() => _BackpackPageState();
}

class _BackpackPageState extends State<BackpackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
            "Your Backpack",
            style: TextStyle(fontSize: 22,color: Color.fromARGB(255, 190, 255, 0)),
            ),
            Text("You won't forget it again!",
            style: TextStyle(letterSpacing: 0.4, fontSize: 10,fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 255, 255))),
            ],
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
                builder: (context) => AddtoBackpack()
              ),
            );
          },
        ),
        drawer: Sidebar(
          tripId: widget.tripId,
        ),
        body: const SafeArea(child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [

            ],
          ),
        )),
    );
  }
}