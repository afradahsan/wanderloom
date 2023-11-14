import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDatabase{
  AdminDatabase();

  final CollectionReference placeCollection = FirebaseFirestore.instance.collection('places');

  Future addPlaces(String? imageURL, String? placeCategory, String? region, String placeName,String location, String placeDescription) async{
    placeCollection.doc().set({
      'Image URL': imageURL,
      'Place Category': placeCategory,
      'Region': region,
      'Place Name': placeName,
      'Location': location,
      'Place Description': placeDescription
    }, SetOptions(merge: true));

  print('addplaces called!');  
  }

  Stream<QuerySnapshot> get places{
    return placeCollection.snapshots();
  }
}