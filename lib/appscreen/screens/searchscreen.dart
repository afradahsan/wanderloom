// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/placedetails.dart';
import 'package:wanderloom/appscreen/widgets/place_listtile.dart';
import 'package:wanderloom/db/functions/adm_database_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  late List searchData = [];
  String name = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final divider = SizedBox(
      height: screenHeight / 80,
    );
    double ten = screenHeight / 80;
    double twenty = screenHeight / 40;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: twenty,
                  ),
                  SizedBox(
                    width: ten,
                  ),
                  SizedBox(
                    height: twenty * 2,
                    width: ten * 26,
                    child: TextField(
                             
                        style: const TextStyle(color: Colors.white),
                        controller: searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(50, 217, 217, 217),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.white),
                          hintText: 'Search here',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(195, 255, 255, 255),
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchController.clear();
                                      searchData.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.white),
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5), // Adjust the padding here

                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              searchData.clear();
                            });
                          } else {
                            setState(() {
                              name = value;
                            });
                          }
                        }),
                  ),
                  SizedBox(
                    width: ten,
                  ),
                  const Icon(
                    Icons.filter_list_rounded,
                    color: Colors.white,
                  )
                ]),
                divider,divider,
                StreamBuilder(
                  stream: AdminDatabase().placeCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('No data available');
                    }
                    Map<String, dynamic> data = {};
                    snapshot.data!.docs.forEach((doc) {
                      data[doc.id] = doc.data() as Map<String, dynamic>;
                    });
                    if (name.isNotEmpty) {
                      searchData = data.entries
                          .where((entry) => entry.value['Place Name']
                              .toString()
                              .toLowerCase()
                              .startsWith(name.toLowerCase()))
                          .toList();
                    } else {
                      searchData.clear();

                      return StreamBuilder(stream: AdminDatabase().places, builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('No data available');
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Popular Searches:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),),
                          divider,
                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return divider;
                            },
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              var doc = snapshot.data!.docs[index];
                              var placeid = doc.id;
                                return PlaceListTile(doc: doc, placeID: doc.id, imageDoc: doc['Image URL'], PlaceDoc: doc['Place Name'], LocationDoc: doc['Location']);
                                }),
                        ],
                      );
                        }));
                        }

                    if (searchData.isEmpty) {
                      // print('dataaa: ${data['']}');
                      return Align(
                        alignment: Alignment.center,
                        child: const Text('Sorry, No matching data found', style: TextStyle(color: Colors.white),));
                    }
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: ((context, index) {
                          return divider;
                        }),
                        itemCount: searchData.length,
                        itemBuilder: (context, index) {
                          var docData = searchData[index].value;
                          var placeID = searchData[index].key; // Access the placeID

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){return PlaceDetailsPage(doc: docData, placeID: placeID);}));
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
                                        child: Image.network(docData['Image URL'], fit: BoxFit.cover,))),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: ten*16,
                                            child: Text(docData['Place Name'],
                                            overflow: TextOverflow.ellipsis, style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),fontSize: 18, fontWeight: FontWeight.w500),),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, size: 12,color: Color.fromARGB(255, 255, 255, 255)),
                                              Text(docData['Location'], style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 12, fontWeight: FontWeight.w400)),
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
                        },
                      ),
                    );
                  },
                )
              ])),
        ));
  }
}
