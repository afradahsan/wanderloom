// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/placedetails.dart';
import 'package:wanderloom/appscreen/widgets/bottom_navbar.dart';
import 'package:wanderloom/db/functions/adm_database_services.dart';
import 'package:wanderloom/db/functions/database_services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(
        child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:
          Padding(padding: const EdgeInsets.fromLTRB(24, 5, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
              divider,
              const Center(
                  child: Text(
                'Keep Exploring!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
              )),
              divider,
              const SizedBox(
                  height: 44,
                  child: SearchBar(
                    padding: MaterialStatePropertyAll(EdgeInsets.only(left: 12)),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(50, 217, 217, 217)),
                    elevation: MaterialStatePropertyAll(0),
                    leading: Icon(
                      Icons.search,
                      color: Color.fromARGB(195, 255, 255, 255),
                    ),
                    hintText: 'Search here',
                    hintStyle: MaterialStatePropertyAll(TextStyle(
                        color: Color.fromARGB(195, 255, 255, 255),
                        fontSize: 16)),
                    // leading: Icon(Icons.search, color: Colors.white,),
                  )),
            divider,
            const Text(
                'Featured Destinations',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              divider,


              StreamBuilder(
                stream: AdminDatabase().places,
                builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){return PlaceDetailsPage(doc: doc,placeID: placeid);
                      }));
                    },
                    child: Container(
                      height: 216.471,
                      width: 325,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                          Image.network(imageURL, fit: BoxFit.cover, height: double.infinity,width: double.infinity,),
                          Positioned(bottom: 0,
                          child: Container(height: 50,width: 325,color: const Color.fromARGB(180, 0, 0, 0),
                          child: Padding(padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(placeName,style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                          Text(location,style: const TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.w400),)],),),),),divider,
                          ],
                          )),
                          ),
                  );
                      }
                    );
                  }
                ),
              ),
              divider,
              const Text('Explore by Category',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
              divider,

              StreamBuilder(stream: AdminDatabase().categories, builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text('No data available');
                  }
                  return Container(
                    height: 130,
                    child: GridView.builder(
                    // reverse: true,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 400),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var categoryImage = doc['Category Image'];
                      var categoryName =  doc['Category Name'];
                    
                      return GestureDetector(
                        onTap: () {
                        },
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(categoryImage,height: double.infinity,width: double.infinity, fit: BoxFit.cover,)),
                                    Positioned(bottom: 0,
                                    child: Container(height: 30,width: 120,decoration: const BoxDecoration(color: Color.fromARGB(180, 0, 0, 0),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                    child: Padding(padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(categoryName,style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),),],),),), 
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
      bottomNavigationBar: BottomNav(
        selectedIndex: 1,
      ),
    );
  }
}