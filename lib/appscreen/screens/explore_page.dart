// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wanderloom/appscreen/screens/categorypage.dart';
import 'package:wanderloom/appscreen/screens/placedetails.dart';
import 'package:wanderloom/appscreen/screens/regionpage.dart';
import 'package:wanderloom/appscreen/screens/searchscreen.dart';
import 'package:wanderloom/appscreen/screens/wishlistpage.dart';
import 'package:wanderloom/db/functions/adm_database_services.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int selectedIndex = 1;
  final divider = const SizedBox(
    height: 10,
  );

  Future<void> onRefresh() async{
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  bool ActiveConnection = true; 
  Future checkUserConnection() async { 
    try { 
    final result = await InternetAddress.lookup('google.com'); 
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { 
      setState(() { 
      ActiveConnection = true; 
      }); 
    } 
    } on SocketException catch (_) { 
    setState(() { 
      ActiveConnection = false; 
    }); 
    }

    if(ActiveConnection==false){
      // ignore: use_build_context_synchronously
      return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("You're Offline!", style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),),),
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("It looks like you're offline.", style: TextStyle(color: Colors.white),),
            Text("Please check your internet connection and try again." ,style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      actions: <Widget>[
          TextButton(
            child: const Text('OK', style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });}
  }
  
    @override 
    void initState() { 
    checkUserConnection(); 
    super.initState(); 
    }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: LiquidPullToRefresh(
        color: const Color.fromARGB(255, 190, 255, 0),
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        animSpeedFactor: 2.0,
        springAnimationDurationInMilliseconds: 800,
        showChildOpacityTransition: false,
        onRefresh: onRefresh,
        child: SafeArea(
          child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
            Padding(padding: const EdgeInsets.fromLTRB(18, 5, 18, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                divider,
                Center(
                  child: Text(
                  'Keep Exploring!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight/28.5,
                    fontWeight: FontWeight.w600),
                )),
                divider,
                StreamBuilder(
                  stream: AdminDatabase().places,
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          Container(height: screenHeight/19,
                              width: screenWidth,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: const Color.fromARGB(70, 255, 255, 255))),
                              SizedBox(height: screenHeight/18,),
                             Container(height: screenWidth/2,
                          width: screenWidth,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color.fromARGB(70, 255, 255, 255))), 
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('No data available');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[0];
                        var placeid = doc.id;
                        var imageURL = doc['Image URL'];
                        
                        print('imageURL: $imageURL');
                        // var placeCategory = doc['Place Category'];
                        // var region = doc['Region'];
                        var placeName = doc['Place Name'];
                        var location = doc['Location'];
                        var placeDescription = doc['Place Description'];
                        print('place naem: $placeName');
                        print('place desc: $placeDescription');
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                            flex: 10,
                            child: SizedBox(
                              height: screenHeight/18.18,
                              width: screenHeight/2.28,
                              child: SearchBar(
                                padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 12)),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(50, 217, 217, 217)),
                                elevation: const MaterialStatePropertyAll(0),
                                leading: const Icon(
                                  Icons.search,
                                  color: Color.fromARGB(195, 255, 255, 255),
                                ),
                                hintText: 'Search here',
                                hintStyle: MaterialStatePropertyAll(TextStyle(
                                    color: const Color.fromARGB(195, 255, 255, 255),
                                    fontSize: screenHeight/50)),
                                onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){return const SearchScreen();}));
                                },
                                // leading: Icon(Icons.search, color: Colors.white,),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){return WishlistPage(doc: doc,);}));
                            }, icon: const FaIcon(FontAwesomeIcons.heart, color: Colors.white,)),),]),           
                            divider,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'Featured Destinations',
                                  style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenHeight/44.44,
                                          fontWeight: FontWeight.w500),
                                ),
                            ),
                              divider,
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){return PlaceDetailsPage(doc: doc,placeID: placeid);
                                }));
                              },
                              child: Container(
                                height: screenHeight/3.69,
                                width: screenWidth,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(screenHeight/40)),
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(screenHeight/80),
                                  child: Stack(
                                    children: [
                                    Image.network(imageURL, fit: BoxFit.cover, height: double.infinity,width: double.infinity,),
                                    Positioned(bottom: 0,
                                    child: Container(height: screenHeight/16,width: screenWidth,color: const Color.fromARGB(180, 0, 0, 0),
                                    child: Padding(padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(placeName,style: TextStyle(color: Colors.white,fontSize: screenHeight/57.14, fontWeight: FontWeight.w500),),
                                    Text(location,style: TextStyle(color: Colors.white,fontSize: screenHeight/66.66, fontWeight: FontWeight.w400),)],),),),),divider,
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          );
                        }
                      );
                    }
                  ),
                ),
      
                divider,
                Text('Explore by Category',style: TextStyle(color: Colors.white,fontSize: screenHeight/44.44,fontWeight: FontWeight.w500),),
                divider,
      
                StreamBuilder(stream: AdminDatabase().categories, builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        children: [
                          Container(height: screenHeight/6.66,
                          width: screenHeight/6.66,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color.fromARGB(70, 255, 255, 255))),
                          SizedBox(width: screenWidth/25,),
                          Container(height: screenHeight/6.66,
                          width: screenHeight/6.66,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color.fromARGB(70, 255, 255, 255))),
                          SizedBox(width: screenWidth/25,),
                          Container(height: screenHeight/6.66,
                          width: screenHeight/18.5,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)), color: Color.fromARGB(70, 255, 255, 255))),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('No data available');
                    }
      
                    return SizedBox(
                      height: screenHeight/6.15,
                      child: GridView.builder(
                      // reverse: true,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 400),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];
                        var categoryImage = doc['Category Image'];
                        var categoryName =  doc['Category Name'];
      
                        // late var categorytypee;
                        // if(doc[''])
                      
                        return GestureDetector(
                          onTap: () {
                            print('tapped');
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){return CategoryPage(categoryName: categoryName, categoryImage: categoryImage, );}));
                          },
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Container(
                                height: screenHeight/6.66,
                                width: screenHeight/6.66,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(categoryImage,height: double.infinity,width: double.infinity, fit: BoxFit.cover,)),
                                      Positioned(bottom: 0,
                                      child: Container(height: screenHeight/26.66,width: screenHeight/6.66,decoration: const BoxDecoration(color: Color.fromARGB(180, 0, 0, 0),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                      child: Padding(padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(categoryName,style: TextStyle(fontSize: screenHeight/57.14, color: Colors.white, fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),],),),), 
                                    )
                                  ]),
                                ),
                              ]),
                            );
                          }),
                        );
                      }),
                divider,
                Text('Explore by Region',style: TextStyle(color: Colors.white,fontSize: screenHeight/44.44,fontWeight: FontWeight.w500),),
                divider,
      
                StreamBuilder(stream: AdminDatabase().region, builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        children: [
                          Container(height: screenHeight/6.66,
                          width: screenHeight/6.66,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color.fromARGB(70, 255, 255, 255))),
                          SizedBox(width: screenWidth/25,),
                          Container(height: screenHeight/6.66,
                          width: screenHeight/6.66,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color.fromARGB(70, 255, 255, 255))),
                          SizedBox(width: screenWidth/25,),
                          Container(height: screenHeight/6.66,
                          width: screenHeight/18.5,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)), color: Color.fromARGB(70, 255, 255, 255))),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('No data available');
                    }
                    return SizedBox(
                      height: screenHeight/6.15,
                      child: GridView.builder(
                      // reverse: true,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 400),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];
                        var regionImage = doc['Region Image'];
                        var regionName = doc['Region Name'];
                      
                        return GestureDetector(
                          onTap: () {
                            print('region tapped');
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){return RegionPage(regionName: regionName, regionImage: regionImage);}));
                          },
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Container(
                                height: screenHeight/6.66,
                                width: screenHeight/6.66,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(regionImage,height: double.infinity,width: double.infinity, fit: BoxFit.cover,)),
                                      Positioned(bottom: 0,
                                      child: Container(height: screenHeight/26.66,width: screenHeight/6.66,decoration: const BoxDecoration(color: Color.fromARGB(180, 0, 0, 0),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                      child: Padding(padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(regionName,style: TextStyle(fontSize: screenHeight/57.14, color: Colors.white, fontWeight: FontWeight.w400),),],),),), 
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                })
              ]),
            ),
          ),
        ),
      ),
    );
  }
}