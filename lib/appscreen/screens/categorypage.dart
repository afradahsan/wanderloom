// ignore_for_file: avoid_print, prefer_const_constructors, unused_import, unused_local_variable, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/placedetails.dart';
import 'package:wanderloom/db/functions/adm_database_services.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({required this.categoryName, required this.categoryImage, super.key});

  var categoryName;
  var categoryImage;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final divider = SizedBox(height: screenHeight/80,);
    double ten = screenHeight/80;
    double twenty = screenHeight/40;

    final uid = FirebaseAuth.instance.currentUser!.uid;

    late var categorytype;

    if(widget.categoryName == 'Heritage/History'){
      categorytype = 'Historical & Heritage Sites';
    }
    if(widget.categoryName == 'Nature & Wildlife'){
      categorytype = 'Nature & Wildlife';
    }
    if(widget.categoryName == 'Pilgrimage Sites'){
      categorytype = 'Pilgrimage sites';
    }
    if(widget.categoryName == 'Trekking Spots'){
      categorytype = 'Trekking/Adventure';
    }
    if(widget.categoryName == 'City Escapes'){
      categorytype = 'Urban Exploration';
    }
    if(widget.categoryName == 'Beaches'){
      categorytype = 'Beaches';
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(child: 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14,14,14,0),
          child: Column(
            children: [
              Container(
                height: ten*12,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ten),
                  image: DecorationImage(
                    image: NetworkImage(widget.categoryImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ten),
                        color: Color.fromARGB(70, 76, 76, 76),
                      ),
                      alignment: Alignment.center,
                      child: Text(widget.categoryName, style: TextStyle(color: Colors.white, fontSize: ten*2.8, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              divider,divider,
              StreamBuilder(
              stream: FirebaseFirestore.instance.collection('places').where('Place Category', isEqualTo: categorytype).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('dataaa waitinggg');
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  print('dataaa erroorr');
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                print('obbbbject');
                  return const Text('No data available');
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, index) {
                    return divider;
                  },
                  itemBuilder: ((context, index) 
                {
                  var doc = snapshot.data!.docs[index];
                  print("this is your doc: $doc");
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){return PlaceDetailsPage(doc: doc, placeID: doc.id);}));
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
                                borderRadius: BorderRadius.circular(ten),
                                child: Image.network(doc['Image URL'], fit: BoxFit.cover,))),
                            Padding(
                              padding: EdgeInsets.only(left: ten*0.8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: ten*16,
                                    child: Text(doc['Place Name'],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),fontSize: ten*1.8, fontWeight: FontWeight.w500),),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 12,color: Color.fromARGB(255, 255, 255, 255)),
                                      Text(doc['Location'], style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: ten*1.2, fontWeight: FontWeight.w400)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      Container(height: twenty,width: twenty, decoration: BoxDecoration(color: Color.fromARGB(30, 255, 255, 255), borderRadius: BorderRadius.circular(ten/2)),child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,size: ten*1.2,),)
                      ],
                    ),
                  ),
                );
                }));
                })]
              ))
          ),
        ),
      );
  }
}