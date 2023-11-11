import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class AddtoBackpack extends StatefulWidget {
  AddtoBackpack({required this.tripId, super.key});
  String tripId;

  @override
  State<AddtoBackpack> createState() => _AddtoBackpackState();
}

class Data {
  String label;
  String icon;

  Data(this.label, this.icon);
}

class _AddtoBackpackState extends State<AddtoBackpack> {
    final List _choiceChipsList = [
    Data('Clothing', "assets/images/t-shirt_1f455.png"),
    Data('Footwear', 'assets/images/running-shoe_1f45f.png'),
    Data('Accessories', 'assets/images/sunglasses_1f576-fe0f.png'),
    Data('Toiletries', 'assets/images/lotion-bottle_1f9f4.png'),
    Data('Travel Gears', 'assets/images/tent_26fa.png'),
    Data('Electronics', 'assets/images/camera_1f4f7.png'),
    Data('Documents', 'assets/images/page-facing-up_1f4c4.png'),
    Data('General', 'assets/images/pill_1f48a.png')
  ];

  int? _selectedIndex;

  String? uid = FirebaseAuth.instance.currentUser!.uid;

  var divider = const SizedBox(height: 10,);
  TextEditingController itemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
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
                            'Add to your Bag!',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              onAdd();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 190, 255, 0)),
                            child: const Text(
                              'Add',
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
                        addtripController: itemController,
                        textformlabel: "What's the item?",
                        textformhinttext: r'Camera\accessories',
                        textformIconPrefix: Icons.backpack_rounded,
                      ),
                      divider,
                      const Text(
                    'Choose Category',
                    style: TextStyle(
                        color: Color.fromARGB(255, 190, 255, 0), fontSize: 16),
                  ),
                  Wrap(children: choiceChips()),
                    ])))));
  }

  Future onAdd() async{
    if(itemController.toString().isNotEmpty && _choiceChipsList[_selectedIndex!].label.toString().isNotEmpty){
      final itemName = itemController.text.toString();
      final itemCategory = _choiceChipsList[_selectedIndex!].label;

      final userId = uid;

      await DatabaseService().savetoBackpack(itemName, itemCategory, userId!, widget.tripId);
    }
    else{
      print('item is empty.');
    }
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
          avatar: Image.asset(_choiceChipsList[i].icon),
          // FaIcon(_choiceChipsList[i].icon, size: 18, color: Color.fromRGBO(21, 24, 43, 1),),
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
}
