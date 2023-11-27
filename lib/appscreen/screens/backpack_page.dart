// ignore_for_file: avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/addto_backpackpage.dart';
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

  @override
  void initState() {
    super.initState();
    isCheckedList = [];
    getBackpackFunction(); 
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
  final refreshedData = await DatabaseService().getBackpack(userId, widget.tripId);
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

  Future updateCheckedStatus(String itemName, bool checkedStatus, String userId, String tripId) async {
  final querySnapshot = await FirebaseFirestore.instance.collection('users')
      .doc(userId)
      .collection('tripdetails')
      .doc(tripId)
      .collection('backpack')
      .where('Item title', isEqualTo: itemName)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final docId = querySnapshot.docs.first.id;
    await FirebaseFirestore.instance.collection('users')
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      floatingActionButton: FloatingButton(
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
        body: SafeArea(
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
                final Map<String, List<Map<String, dynamic>>> groupBackpack = groupBackpackByCategory(backpack);
                final categories = groupBackpack.keys.toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) {
                    return divider;
                  },
                  itemBuilder: (context, index) {
                    if(isCheckedList == null){
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
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              categ,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 190, 255, 0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 56*itemsForCateg.length.toDouble(),
                          width: 320,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(50, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: 
                              List.generate(itemsForCateg.length, (itemIndex) {
                              final item = itemsForCateg[itemIndex];
                              return checkBoxWidget(item, itemIndex);
                              }
                          ),
                          )
                        ),
                      ],
                    );
                  },
                );
              }
              return const Center(
                  child: CircularProgressIndicator());
              }
              )
              )
            )));
  }

  checkBoxWidget(Map<String, dynamic> item, int itemIndex) {
  return CheckboxListTile(
    side: const BorderSide(color: Color.fromARGB(255, 190, 255, 0)),
    title: Text(
      item['Item title'],
      style: const TextStyle(fontSize: 16, color: Colors.white),
    ),
    controlAffinity: ListTileControlAffinity.leading,
    checkColor: const Color.fromARGB(255, 255, 255, 255),
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color.fromARGB(255, 190, 255, 0);
        }
        return Colors.transparent;
      },
    ),
    value: item['Item Checked'],
    onChanged: (bool? value) {
  setState(() {
    item['Item Checked'] = value ?? false;
    refreshData();
  });
  // Call the function to update the checked status in the database
  updateCheckedStatus(item['Item title'], value ?? false, userId, widget.tripId);
  },
  );
}
}