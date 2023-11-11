import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  var res;
  @override
  void initState() {
    super.initState();
    getBackpackFunction(); 
  }
  final divider = const SizedBox(
    height: 10,
  );
  final wdivider = const SizedBox(
    width: 10,
  );
  bool isChecked = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future getBackpackFunction() async {
    return res = await DatabaseService().getBackpack(userId, widget.tripId);
  }

groupBackpackByCategory(List<Map<String, dynamic>>? backpacklst) {
  print("backpacklst: $backpacklst");
  final groupBackpack = <String, List<Map<String, dynamic>>>{};

  if (backpacklst != null) {
    print('backpack list not null');
    for (var item in backpacklst) {
      print('item not null $item');
      print('item: ${item['Item Category']}');

      final category = item['Item Category'] as String? ?? 'Other';
      print('item title not null $item');
      print('item title: ${item['Item title']}');
      final title = item['Item title'] as String? ?? 'Unknown Title';

      if (groupBackpack.containsKey(category)) {
        groupBackpack[category]!.add(item);
      } else {
        groupBackpack[category] = [item];
      }
    }
  }
  return groupBackpack;
}


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
                style: TextStyle(
                    fontSize: 22, color: Color.fromARGB(255, 190, 255, 0)),
              ),
              Text("You won't forget it again!",
                  style: TextStyle(
                      letterSpacing: 0.4,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 255, 255, 255))),
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
                  builder: (context) => AddtoBackpack(
                        tripId: widget.tripId,
                      )),
            );
          },
        ),
        drawer: Sidebar(
          tripId: widget.tripId,
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
                  final Map<String, List<Map<String, dynamic>>> groupBackpack =
                      groupBackpackByCategory(backpack);

                  final categories = groupBackpack.keys.toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
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
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 190, 255, 0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 160,
                            width: 320,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(50, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                for (var item in itemsForCateg)
                                  checkBoxWidget(item['Item title']),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                          return const Center(
                              child: CircularProgressIndicator());
                        })))));
  }

  checkBoxWidget(String itemTitile) {
    return CheckboxListTile(
        side: MaterialStateBorderSide.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return const BorderSide(
              color: Color.fromARGB(255, 190, 255, 0),
            );
          } else {
            return const BorderSide(
              color: Color.fromARGB(255, 190, 255, 0),
            );
          }
        }),
        title: Text(itemTitile,
            style: TextStyle(fontSize: 16, color: Colors.white)),
        controlAffinity: ListTileControlAffinity.leading,
        checkColor: const Color.fromARGB(255, 255, 255, 255),
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return const Color.fromARGB(255, 190, 255, 0);
          }
          return Colors.transparent;
        }),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        });
  }
}
