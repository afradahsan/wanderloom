import 'package:cloud_firestore/cloud_firestore.dart';

final sample = FirebaseFirestore.instance;

Future insertData(String name, int rollNo)async{
  sample.collection('sample').doc().set({
    'Name': name,
    'Roll No': rollNo,
  }, SetOptions(merge: true));
}