import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  final divider = SizedBox(height: 10,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(
      child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: StreamBuilder(
                stream: AdminDatabase().places, 
                builder: ((context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text('No data available');
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  var doc = snapshot.data!.docs[index];
                  var imageURL = doc['Image URL'];
                  var placeCategory = doc['Place Category'];
                  var region = doc['Region'];
                  var placeName = doc['Place Name'];
                  var location = doc['Location'];
                  var placeDescription = doc['Place Description'];

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        divider,
                        Center(child: Text('Keep Exploring!', style: TextStyle(color: Colors.white, fontSize: 28  , fontWeight: FontWeight.w600),)),
                        divider,
                        SizedBox(
                          height: 44,
                          child: SearchBar(
                            padding: MaterialStatePropertyAll(EdgeInsets.only(left: 12)),
                            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(50, 217, 217, 217)),
                            elevation: MaterialStatePropertyAll(0),
                            leading: Icon(Icons.search, color: const Color.fromARGB(195, 255, 255, 255),),
                            hintText: 'Search here',
                            hintStyle: MaterialStatePropertyAll(TextStyle(color: const Color.fromARGB(195, 255, 255, 255), fontSize: 16)),
                            // leading: Icon(Icons.search, color: Colors.white,),
                          )),
                          divider,
                        Text('Featured Destinations', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                        divider,
                        // Card(color: Colors.transparent,
                        //   child: ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Image.network(imageURL)),)
                        Container(
                          height: 216.471,
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child:                       ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.network(imageURL, fit: BoxFit.cover,),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                  height: 50,
                                  width: 320,
                                  color: const Color.fromARGB(150, 0, 0, 0),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(8,5,0,0),
                                    child: Column
                                    (crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [Text(placeName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),), Text(location, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),)],),
                                  ),),
                                ),
                              ],
                            )),
                        ),
                        divider,
                        Text('Explore by Category', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                        divider,
                        
                      ],
                    ),
                  );
                }
                
                );
              }))
      ),
      ),
        bottomNavigationBar: BottomNav(selectedIndex: 1,),
      );
  }
}