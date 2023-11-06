// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:wanderloom/auth/db/signup_model.dart';

// // ValueNotifier<List<UserModel>> usersignupnotifier = ValueNotifier([]);

// Future<void> addUserDetails(UserModel signupvalue) async{
//   final signupDB = await Hive.box<UserModel>('signup_db');
//   await signupDB.add(signupvalue);

//   print('SIGN UP DATA SAVED!');
//   // usersignupnotifier.value.add(value);
//   // usersignupnotifier.notifyListeners();
// }

// Future<Box<UserModel>> getUserDetails() async{
//   final signupDB = await Hive.box<UserModel>('signup_db');
//   return signupDB;
//   // usersignupnotifier.value.addAll(signupDB.values);
//   // usersignupnotifier.notifyListeners();
// } 
