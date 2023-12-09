// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/adminscreens/adminpage.dart';
class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  //reference for our collections
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  //Updating the Userdata
  Future saveUserData(String email, String username) async{
    print('SAVE USER DATA CALLED!');
    print('signup user id: $uid');
    return await userCollection.doc(uid).set({
      'userName': username,
      'email': email,
      'uid': uid,
    });
  }

  Future getUserData(String email) async{
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  Future saveTripData(String tripname, String   tripbudget, String tripdate, String tripcategory,   String tripparticipants, String? userid) async {
    print('SAVE TRIP DATA CALLED!');
    print('user id $userid');
  
  // Reference to the user's document
    DocumentReference userDoc = userCollection.doc(userid);
    userDoc.collection('tripdetails').doc().set({
        'tripname': tripname,
        'tripbudget': tripbudget,
        'tripdate': tripdate,
        'tripcategory': tripcategory,
        'tripparticipants': tripparticipants,
    },SetOptions(merge: true));
  }

  Future<List<Map<String, dynamic>>?> getTripDetails(String userId) async {
  QuerySnapshot tripDetailsSnapshot =
      await userCollection.doc(userId).collection('tripdetails').get();

  List<Map<String, dynamic>> tripDetailsList = [];

  tripDetailsSnapshot.docs.forEach((doc) {
    final tripData = doc.data() as Map<String, dynamic>;
    final tripId = doc.id;
    tripData['tripId'] = tripId; // Add the tripId to the map
    tripDetailsList.add(tripData);
  });
  return tripDetailsList;
}

  Future<String?> getTripIdForUser(String userId) async {
  QuerySnapshot tripDetailsSnapshot =
    await userCollection.doc(userId).collection('tripdetails').get();
  if (tripDetailsSnapshot.docs.isNotEmpty) {
    // Assuming you want to get the tripId for the first trip in the list
    final tripId = tripDetailsSnapshot.docs.first.id;
    print('getTripIdForUser calleddd');
    return tripId;
  } else {
    return null; // Handle the case where no trip is found
    }
  }

  Future<String?> getBudget(String userId, String tripId) async {
  DocumentSnapshot tripDetailsDoc = await userCollection
      .doc(userId)
      .collection('tripdetails')
      .doc(tripId)
      .get();
  if (tripDetailsDoc.exists) {
    final tripData = tripDetailsDoc.data() as Map<String, dynamic>;
    final budget = tripData['tripbudget'] as String;
    print('get budget called, budget is $budget');
    return budget;
  } else {
    return null; // Handle the case where the trip or budget is not found
  }
}

  // Future<List<Map<String,dynamic>>> getTripDetails(String userId) async{
  //   QuerySnapshot tripDetailsSnapshot = await userCollection.doc(userId).collection('tripdetails').get();
  //   List<Map<String, dynamic>> tripdetailslist = [];  
  //   tripDetailsSnapshot.docs.forEach((doc) {
  //     tripdetailslist.add(doc.data() as Map<String, dynamic>);
  //   });
  //   return tripdetailslist;
  // }

  Future saveItinerary(String ItnLocation, String ItnDate, String ItnTime, String ItnDescription, String ItnLinks, String? userId, String tripId) async{
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('itinerary').doc().set({
      'location': ItnLocation,
      'date': ItnDate,
      'time': ItnTime,
      'description': ItnDescription,
      'links': ItnLinks
    },SetOptions(merge: true));

    print('SAVE ITINERARY CALLED.');
    print('trip id: $tripId');
  }

  Future getItinerary(String userId, String tripId) async{
    QuerySnapshot itineraryDetailsSnapshot = await userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('itinerary').get();

    List<Map<String, dynamic>> itineraryList = [];

    itineraryDetailsSnapshot.docs.forEach((doc) {
      final itinerarydata = doc.data() as Map<String, dynamic>;
      itinerarydata['id'] = doc.id; // This line adds the 'id' to the map
      itineraryList.add(itinerarydata);
    });

    return itineraryList;
  }

  Future updateItinerary(String itineraryId, String ItnLocation, String ItnDate, String ItnTime, String ItnDescription, String ItnLinks, String? userId, String tripId) async{
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('itinerary').doc(itineraryId).update({
      'location': ItnLocation,
      'date': ItnDate,
      'time': ItnTime,
      'description': ItnDescription,
      'links': ItnLinks
    });
    print('update itineraryy');
  }

  Future deleteItinerary(String userId, String tripId, String itineraryId) async{
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('itinerary').doc(itineraryId).delete();
    print('deleted itinerary!');
  }

  Future saveExpense(String expenseTitle,String expenseCategory,int expense, String? expenseDate, String? userId, String tripId) async{
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('expense').doc().set({
      'expense title': expenseTitle,
      'expense category': expenseCategory,
      'expense date': expenseDate,
      'expense': expense
    }, SetOptions(merge: true));

    print('SAVE EXPENSE CALLLED!');
    print('exp date: $expenseDate');
  }

  Future getExpense(String userId, String tripId) async{
    QuerySnapshot expenseSnapshot = await userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('expense').get();

    List<Map<String, dynamic>> expenseList = [];

    expenseSnapshot.docs.forEach((doc) {
      final expensedata = doc.data() as Map<String, dynamic>;
      expensedata['id'] = doc.id;

      expenseList.add(expensedata);
     });

     return expenseList;
  }

  Future updateExpense(String expenseTitle, String expenseCategory,int expense, String? expenseDate, String? userId, String tripId, String BudgetId) async{
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('expense').doc(BudgetId).update({
      'expense title': expenseTitle,
      'expense category': expenseCategory,
      'expense date': expenseDate,
      'expense': expense
    });
    print('budget update called');
  }

  Future deleteExpense(String userId, String tripId, String BudgetId) async{
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('expense').doc(BudgetId).delete();
    print('deleted expense');
  }

  Future savetoBackpack(String itemName, String itemCategory, String userId, String tripId, {bool itemcheck = false}) async {
  await userCollection
      .doc(userId)
      .collection('tripdetails')
      .doc(tripId)
      .collection('backpack')
      .add({
    'Item title': itemName,
    'Item Category': itemCategory,
    'Item Checked': itemcheck,
  });

  print('save to backpack called!');
  print('item name: $itemName');
}

  Future getBackpack(String userId, String tripId) async{
    QuerySnapshot backpacksnapshot = await userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('backpack').get();

    List<Map<String, dynamic>> backpacklist = [];

    backpacksnapshot.docs.forEach((doc) {
      final backpackdata = doc.data() as Map<String, dynamic>;
      backpackdata['id'] = doc.id; 
      backpacklist.add(backpackdata);
    });
    return backpacklist;
  }

  Future updateBackpack(String itemName, String itemCategory, String userId, String tripId, String backpackId, {bool itemcheck = false}) async{
    await userCollection
      .doc(userId)
      .collection('tripdetails')
      .doc(tripId)
      .collection('backpack')
      .doc(backpackId).update({
    'Item title': itemName,
    'Item Category': itemCategory,
    'Item Checked': itemcheck,
  });

  print('update backpack called!');
  print('item name: $itemName');
  }

  Future savetoNotes(String notesTitle, String notesDescription, String userId, String tripId) async{
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('notes').doc().set({
      'Notes title': notesTitle,
      'Notes description': notesDescription,
    }, SetOptions(merge: true));

    print('save to notes called!');
    print('note title: $notesTitle');
  }

  Future getNotes(String userId, String tripId) async{
    QuerySnapshot notesSnapshot = await userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('notes').get();

    List<Map<String,dynamic>> noteslist = [];

    notesSnapshot.docs.forEach((doc) {
      final notesdata = doc.data() as Map<String, dynamic>;
      notesdata['id'] = doc.id;
      noteslist.add(notesdata);
     });
     print('NOTESLISTT: $noteslist');
     return noteslist;
  }

  Future updateNotes(String notesTitle, String notesDescription, String userId, String tripId, String notesId) async{
    print('noted: $notesDescription');
    print('notet: $notesTitle');
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('notes').doc(notesId).update({
      'Notes title': notesTitle,
      'Notes description': notesDescription,
    });
    print('notes updated');
  }
  
  Future deleteNotes(String userId, String tripId, String notesId) async{
    userCollection.doc(userId).collection('tripdetails').doc(tripId).collection('notes').doc(notesId).delete();
    print('deleted note.');
  }
}