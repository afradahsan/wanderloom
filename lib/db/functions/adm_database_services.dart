import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDatabase{
  AdminDatabase();

  final CollectionReference placeCollection = FirebaseFirestore.instance.collection('places');

  final CollectionReference categoryCollection = FirebaseFirestore.instance.collection('category');

  final CollectionReference regionCollection = FirebaseFirestore.instance.collection('region');


  Future addPlaces(String? imageURL, String? placeCategory, String? region, String placeName,String location, String placeDescription, String weatherRange, String bestTime, String bestTimeDesc, String indianRate, String foriegnRate, String howtoReach, String navLink) async{
    placeCollection.doc().set({
      'Image URL': imageURL,
      'Place Category': placeCategory,
      'Region': region,
      'Place Name': placeName,
      'Location': location,
      'Place Description': placeDescription,
      'Weather': weatherRange,
      'Best Time': bestTime,
      'Best Time Desc': bestTimeDesc,
      'Indian Rate': indianRate,
      'Foriegner Rate': foriegnRate,
      'How to Reach': howtoReach,
      'Nav Link': navLink,
    }, SetOptions(merge: true));

  print('addplaces called!');  
  }

  Stream<QuerySnapshot> get places{
    return placeCollection.snapshots();
  }

  Future addCategory(String? categoryImage, String? categoryName) async{
    categoryCollection.doc().set({
      'Category Image': categoryImage,
      'Category Name': categoryName
    }, SetOptions(merge: true));
    print('addCategory called!');
  }

  Stream<QuerySnapshot> get categories{
    return categoryCollection.snapshots();
  }

  Future addRegion(String? regionImage, String? regionName) async{
    regionCollection.doc().set({
      'Region Image': regionImage,
      'Region Name': regionName
    }, SetOptions(merge: true));
    print('addregion called!');
  }

  Stream<QuerySnapshot> get region{
    return regionCollection.snapshots();
  }

  Future updateData(String placeId, String placeName) async{
    placeCollection.doc(placeId).update({
      'Place Name': placeName
    });
    print('updatedata called');
  }
}