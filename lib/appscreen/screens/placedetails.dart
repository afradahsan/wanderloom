// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanderloom/appscreen/adminscreens/editplacedetails.dart';
import 'package:wanderloom/db/functions/adm_database_services.dart';
import 'package:wanderloom/db/models/favourites_model.dart';

class PlaceDetailsPage extends StatefulWidget {

  PlaceDetailsPage({
    required this.doc, required this.placeID, super.key});

  dynamic doc;
  String? placeID;

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {

  bool heartTap = false;

    List favList = [];

  @override
  void initState() {
    super.initState();
    getFavourites();
    var favbox = Hive.box('favouritesBox');
    var favid = favbox.get('id');
    heartTap = true ? favid == widget.placeID: false;
  }

  void getFavourites() async {
    var favbox = Hive.box('favouritesBox');
    List tempList = favbox.values.toList();
    print('object: $tempList');
    setState(() {
      favList = tempList;
    });
  }

  void addToFavorites() {
    var box = Hive.box('favouritesBox');
    box.add(FavouritesModel(
      id: widget.placeID!,
      placeName: widget.doc['Place Name'],
      location: widget.doc['Location'],
      image: widget.doc['Image URL'],
      doc: widget.doc,
    ));
    getFavourites();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final divider = SizedBox(height: screenHeight/80,);
    double ten = screenHeight/80;
    double twenty = screenHeight/40;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    print(screenHeight);
    print("width: $screenWidth");

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async{
      final url = '${widget.doc['Nav Link']}';
      launchUrl(Uri.parse(url)).onError(
        (error, stackTrace) {
          print("Url is not valid!");
          return false;
        },
      );
      },
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: const Color.fromARGB(255, 190, 255, 0),
      child: Image.asset('assets/images/navigation_3d.png', height: ten*2.5,),),
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(ten*1.8,twenty,ten*1.8,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight/3.5, 
                  width: screenWidth-36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(ten),
                      child: Image.network(widget.doc['Image URL'],height: double.infinity, width: double.infinity, fit: BoxFit.cover),),
                      Positioned(
                        left: ten/2,
                        top: ten/2,
                        child: IconButton(icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, color: Colors.white,)),
                      if (uid == 'BarF8kEyiuQ7ps3pupuFqpBJ0dZ2') 
                        Positioned(
                        right: ten/4,
                        top: ten/2,
                        child: Row(
                          children: [
                            IconButton(icon: Icon(Icons.edit, color: Color.fromARGB(255, 255, 255, 255),size: twenty,),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){return EditPlaceDetailsPage(doc: widget.doc, placeID: widget.placeID, placeName: widget.doc['Place Name'], location: widget.doc['Location'], description: widget.doc['Place Description'], weather: widget.doc['Weather'], bestTime: widget.doc['Best Time'], bestTimeDesc: widget.doc['Best Time Desc'], rateInd: widget.doc['Indian Rate'], rateFor: widget.doc['Foriegner Rate'], howtoReach: widget.doc['How to Reach'], navLink: widget.doc['Nav Link']);}));
                            }),
                            IconButton(icon: Icon(Icons.delete, color: Colors.red,size: twenty,),
                            onPressed: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('Are you sure you want to delete?', style: TextStyle(color: Colors.white, fontSize: 18),),
                                  actions: [
                                    TextButton(onPressed: (){
                                      AdminDatabase().deletePlace(widget.placeID).then((value){
                                        SnackBar(content: (Text('Place Deleted Successfully!')));
                                      });
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    }, child: Text('Yes', style: TextStyle(color: Color.fromARGB(255, 190, 255, 0)),)),
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child: Text('No',style: TextStyle(color: Color.fromARGB(255, 190, 255, 0)),))
                                  ],
                                  backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
                                );
                              });
                            }),
                          ],
                        )),
                    ],
                  ),
                  ),
                divider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.doc['Place Name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ten*2.6),),
                    GestureDetector(
                      onTap: () {
                        addToFavorites();
                      setState(() {
                        heartTap = !heartTap;
                      });
                      },
                      child: heartTap==false ? FaIcon(FontAwesomeIcons.heart, color: Colors.white,size: 20,) : FaIcon(FontAwesomeIcons.solidHeart, color: const Color.fromARGB(255, 190, 255, 0), size: 21,)),
                  ],
                ),
                divider,

                ReadMoreText(
                ' ${widget.doc['Place Description']}',
                trimLines: 5,
                style: TextStyle(color: const Color.fromARGB(180, 255, 255, 255), fontSize: ten*1.4,)
                ),
                divider,
                divider,
                Row(
                  children: [
                    Container(
                      height: ten*4,
                      width: ten*4,
                      decoration: BoxDecoration(color: const Color.fromARGB(128, 255, 255, 255), borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.5),spreadRadius: 2,blurRadius: 7,offset: const Offset(3, 3),
                        ),
                      ]),
                      child: Image.asset('assets/images/star_3d.png'),
                    ),SizedBox(width: ten/2,),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('4.4',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ten*1.4),),
                            Icon(Icons.star, color: Colors.white,size: ten*1.5,),
                          ],
                        ),
                        Text('8 ratings',
                        style: TextStyle(decoration: TextDecoration.underline, color: const Color.fromARGB(180, 255, 255, 255), fontSize: ten*1.2,))
                      ],
                    ),
                    SizedBox(width: ten*7,),
                    Container(
                      height: ten*4,
                      width: ten*4,
                      decoration: BoxDecoration(color: const Color.fromARGB(128, 255, 255, 255), borderRadius: BorderRadius.circular(ten/2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.5),spreadRadius: 2,blurRadius: 7,offset: const Offset(3, 3),
                        ),
                      ]),
                      child: Image.asset('assets/images/weather_3d.png')),
                      SizedBox(width: ten/2,),
                      Text('${widget.doc['Weather']}', style: TextStyle(color: Colors.white, fontSize: ten*1.8, fontWeight: FontWeight.w500),)
                  ],
                ),
                
                divider,divider,
                Text('Best time to visit:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ten*1.7)),
                divider,
                Container(
                  height: ten*3.5,
                  width: ten*16,
                  decoration: BoxDecoration(color: const Color.fromARGB(105, 207, 207, 207), borderRadius: BorderRadius.circular(ten/2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.5),spreadRadius: 2,blurRadius: 7,offset: const Offset(3, 3),
                    ),
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month_rounded, color: Colors.white,size: ten*1.8),
                      SizedBox(width: ten/2,),
                      Text('${widget.doc['Best Time']}', style: TextStyle(color: const Color.fromARGB(255, 250, 215, 27), fontWeight: FontWeight.w600, fontSize: ten+4, )),
                    ],
                  ),
                  ),
                divider,
                Text('${widget.doc['Best Time Desc']}' , style: TextStyle(color: const Color.fromARGB(190, 255, 255, 255), fontWeight: FontWeight.w500, fontSize: ten+2)),
                divider,
                Text('Entry Fee:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: twenty-3)),
                SizedBox(height: ten/2,),
                Row(children: [const Icon(Icons.circle, size: 7, color: Colors.white,),
                SizedBox(width: ten/2,),
                Text('Indian - ₹${widget.doc['Indian Rate']}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ten+3)),
                ],),
                Row(children: [const Icon(Icons.circle, size: 7, color: Colors.white,),
                SizedBox(width: ten/2,),
                Text('Foreigner - ₹${widget.doc['Foriegner Rate']}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ten+3)),
                ],),
                divider,
                Text('How to reach?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: twenty-3)),
                SizedBox(height: ten/2,),
                Text('${widget.doc['How to Reach']}' , style: TextStyle(color: const Color.fromARGB(190, 255, 255, 255), fontWeight: FontWeight.w500, fontSize: ten+2)),
              ],
            ),
          )
        ),
      ),
    );
  }
}