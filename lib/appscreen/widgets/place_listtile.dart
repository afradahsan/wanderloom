// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/placedetails.dart';

class PlaceListTile extends StatefulWidget {
  PlaceListTile({required this.doc, required this.placeID, required this.imageDoc, required this.PlaceDoc, required this.LocationDoc, super.key});

  var doc;
  var placeID;
  var imageDoc;
  var PlaceDoc;
  var LocationDoc;

  @override
  State<PlaceListTile> createState() => _PlaceListTileState();
}

class _PlaceListTileState extends State<PlaceListTile> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final divider = SizedBox(
      height: screenHeight / 80,
    );
    double ten = screenHeight / 80;
    double twenty = screenHeight / 40;
    
    return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){return PlaceDetailsPage(doc: widget.doc, placeID: widget.placeID);}));
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
                                child: Image.network(widget.imageDoc, fit: BoxFit.cover,))),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: ten*16,
                                    child: Text(widget.PlaceDoc,
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),fontSize: 18, fontWeight: FontWeight.w500),),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 12,color: Color.fromARGB(255, 255, 255, 255)),
                                      Text(widget.LocationDoc, style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 12, fontWeight: FontWeight.w400)),
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
  }
}