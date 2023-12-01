// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wanderloom/appscreen/screens/placedetails.dart';
import 'package:wanderloom/appscreen/widgets/place_listtile.dart';
import 'package:wanderloom/db/models/placemodel.dart';

class WishlistPage extends StatefulWidget {
  WishlistPage({required this.doc, super.key});

  dynamic doc;

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {

  Box placeBox = Hive.box('places');

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final divider = SizedBox(
      height: screenHeight / 80
    );
    double ten = screenHeight / 80;
    double twenty = screenHeight / 40;

    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 24, 43, 1),
      appBar: AppBar(title: Text('Your Wishlist!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0,),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 670,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return divider;
                },
                itemCount: placeBox.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                PlaceModel place = placeBox.getAt(index)!;
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){return PlaceDetailsPage(doc: widget.doc, placeID: place.placeID);}));
                    },
                    child: Container(
                      padding: EdgeInsets.all(ten+5),
                      height: ten*10,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(30, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(ten))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: ten*8,
                                width: ten*8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(place.image, fit: BoxFit.cover,))),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: ten*16,
                                      child: Text(place.placeName,
                                      overflow: TextOverflow.ellipsis, style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),fontSize: 18, fontWeight: FontWeight.w500),),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: 12,color: Color.fromARGB(255, 255, 255, 255)),
                                        Text(place.location, style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 12, fontWeight: FontWeight.w400)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(height: twenty,width: twenty, decoration: BoxDecoration(color: Color.fromARGB(30, 255, 255, 255), borderRadius: BorderRadius.circular(5)),child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,size: 12,),)
                        ],
                      ),
                    ),
                  );
              }),
            )         
          ],
        ),
      )),
    );
  }
}