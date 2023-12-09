// ignore_for_file: avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/addto_backpackpage.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/editbackpack.dart';
import 'package:wanderloom/appscreen/widgets/floatingbutton.dart';
import 'package:wanderloom/appscreen/widgets/side_menubar.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class BackpackPage extends StatefulWidget {
  BackpackPage({required this.tripId, super.key});
  String tripId;

  @override
  State<BackpackPage> createState() => _BackpackPageState();
}

class _BackpackPageState extends State<BackpackPage> {
  var getData;
  List<bool> isCheckedList = [];
  bool checkvalue = false;

  @override
  void initState() {
    super.initState();
    isCheckedList = [];
    getBackpackFunction();
  }

  Future<void> onRefresh() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  final divider = const SizedBox(
    height: 10,
  );
  final wdivider = const SizedBox(
    width: 10,
  );
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future getBackpackFunction() async {
    print('Fetching backpack data...');
    getData = await DatabaseService().getBackpack(userId, widget.tripId);
    print('Backpack data fetched: $getData');

    // isCheckedList = initializeCheckedList(getData);
    // print("that is ?$isCheckedList");
    print('isCheckedList initialized: $isCheckedList');
    return getData;
  }

  void refreshData() async {
    final refreshedData =
        await DatabaseService().getBackpack(userId, widget.tripId);
    setState(() {
      getData = refreshedData;
    });
  }

  // List<bool> initializeCheckedList(List<Map<String, dynamic>> backpackList) {
  //   return List.generate(backpackList.length, (index) => false);
  // }

  groupBackpackByCategory(List<Map<String, dynamic>>? backpacklst) {
    // print("backpacklst: $backpacklst");
    final groupBackpack = <String, List<Map<String, dynamic>>>{};

    if (backpacklst != null) {
      print('backpack list not null');
      for (var item in backpacklst) {
        // print('item not null $item');
        // print('item: ${item['Item Category']}');

        final category = item['Item Category'] as String? ?? 'Other';
        // print('item title not null $item');
        // print('item title: ${item['Item title']}');

        if (groupBackpack.containsKey(category)) {
          groupBackpack[category]!.add(item);
        } else {
          groupBackpack[category] = [item];
        }
      }
    }
    return groupBackpack;
  }

  Future updateCheckedStatus(
      String itemName, bool checkedStatus, String userId, String tripId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tripdetails')
        .doc(tripId)
        .collection('backpack')
        .where('Item title', isEqualTo: itemName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tripdetails')
          .doc(tripId)
          .collection('backpack')
          .doc(docId)
          .update({'Item Checked': checkedStatus});
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        floatingActionButton: FloatingButton(
          bottom: 20,
          onPressed: () {
            print('tripiddd: $widget.tripId');
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddtoBackpack(
                        tripId: widget.tripId,
                      )),
            );
          },
        ),
        body: LiquidPullToRefresh(
          color: Color.fromARGB(255, 190, 255, 0),
          backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
          animSpeedFactor: 2.0,
          springAnimationDurationInMilliseconds: 800,
          showChildOpacityTransition: false,
          onRefresh: onRefresh,
          child: SafeArea(
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: FutureBuilder(
                          future: getBackpackFunction(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              print('Waiting for data');
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
                              final backpack = snapshot.data;
                              print("backpack: $backpack");
                              final Map<String, List<Map<String, dynamic>>>
                                  groupBackpack =
                                  groupBackpackByCategory(backpack);
                              final categories = groupBackpack.keys.toList();
        
                              if (groupBackpack.isEmpty) {
                            return Container(
                              height: screenHeight/1.4,
                              width: screenWidth,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.backpack, size: 120, weight: 2,fill: 1, color: Color.fromARGB(50, 255, 255, 255),),
                                  Text('Tap on the + to add to your Backpack', style: TextStyle(fontSize: 16, color: Color.fromARGB(50, 255, 255, 255),),)
                                ],
                              ),
                            );
                          }
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: categories.length,
                                separatorBuilder: (context, index) {
                                  return divider;
                                },
                                itemBuilder: (context, index) {
                                  if (isCheckedList == null) {
                                    print('checkeddlisttt iss nulll');
                                  }
                                  final categ = categories[index];
                                  final itemsForCateg = groupBackpack[categ]!;
        
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/tent_26fa.png',
                                            height: screenHeight/40,
                                          ),
                                          SizedBox(width: screenHeight/80,),
                                          Text(
                                            categ,
                                            style: TextStyle(
                                              fontSize: screenHeight/50,
                                              color: Color.fromARGB(
                                                  255, 190, 255, 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight/80,),
                                      Container(
                                          height: screenHeight/13.5 * itemsForCateg.length.toDouble(),
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                50, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            children: List.generate(
                                                itemsForCateg.length,
                                                (itemIndex) {
                                              final item =
                                                  itemsForCateg[itemIndex];
                                              // final itemid = item['id'];
                                              return checkBoxWidget(
                                                  item, itemIndex);
                                            }),
                                          )),
                                    ],
                                  );
                                },
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          })))),
        ));
  }

  checkBoxWidget(Map<String, dynamic> item, int itemIndex) {
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return EditBackpack(tripId: widget.tripId, backpackId: item['id']);
        }));
      },
      child: CheckboxListTile(
          side: const BorderSide(color: Color.fromARGB(255, 190, 255, 0)),
          controlAffinity: ListTileControlAffinity.leading,
          checkColor: const Color.fromARGB(255, 255, 255, 255),
          checkboxShape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Colors.black)),
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color.fromARGB(255, 190, 255, 0);
              }
              return Colors.transparent;
            },
          ),
          enableFeedback: true,
          
          value: item['Item Checked'],
          onChanged: (bool? value) {
            setState(() {
              item['Item Checked'] = value ?? false;
              refreshData();
              checkvalue = value ?? false;
            });
            // Call the function to update the checked status in the database
            updateCheckedStatus(
                item['Item title'], value ?? false, userId, widget.tripId);
          },
          title: Text(
            item['Item title'],
            style: TextStyle(
              fontSize: 16,
              color: item['Item Checked'] ? const Color.fromARGB(127, 255, 255, 255) : Colors.white,
              decoration:
                  item['Item Checked'] ? TextDecoration.lineThrough : null,
            ),
          )),
    );
  }
}
