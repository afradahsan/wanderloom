import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wanderloom/appscreen/widgets/place_listtile.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
  List favList = [];

  void getFavourites() async {
    var favbox = Hive.box('favouritesBox');
    print('object: ${favbox.length}');
    List tempList = favbox.values.toList();
    print('tempList $tempList');
    setState(() {
      favList = tempList;
    });
  }

  @override
  void initState() {
    super.initState();
    getFavourites();
    print('dattaa');
  }   

    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 24, 43, 1),
      appBar: AppBar(title: Text('Your Wishlist!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0,),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('data'),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                  var favItem = favList[index];
                  print('fav: ${favItem.doc}');
                  return PlaceListTile(
                    doc: favItem.doc,
                    placeID: favItem.id,
                    imageDoc: favItem.image,
                    PlaceDoc: favItem.placeName,
                    LocationDoc: favItem.location,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10,);
                },
                itemCount: favList.length,
                )
          ],
        ),
      )),
    );
  }
}