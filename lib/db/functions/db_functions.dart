// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:wanderloom/auth/db/signup_model.dart';
// import 'package:wanderloom/db/models/data_model.dart';
 
// // ValueNotifier<List<TripDetailsModel>> tripdetailsnotifier = ValueNotifier([]);

// Future<void> addTripDetails(TripDetailsModel trip) async{
//   final tripDB = await Hive.box('signup_db');
//   await tripDB.add(trip);

//   //  int _id= await tripDB.add(trip);
//   //  trip.id=_id;
  
//   // tripdetailsnotifier.value.add(value);
//   // tripdetailsnotifier.notifyListeners();
//   print('Logging: ${trip.trippcategorytitle}');
//   print('Trip Db: ${tripDB.values.toList()}');
// }

// Future<List> getTripDetails() async{
//   final tripDB = await Hive.box('signup_db');
//   final triplist = tripDB.values.toList();
//   return triplist;
//   // tripdetailsnotifier.value.clear();
//   // tripdetailsnotifier.value.addAll(tripDB.values);
//   // tripdetailsnotifier.notifyListeners();
//   print('notified!');
// }