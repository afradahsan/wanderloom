import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wanderloom/auth/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wanderloom/db/models/firestore_adapters.dart';
import 'package:wanderloom/db/models/favourites_model.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(FavouritesModelAdapter());
  Hive.registerAdapter(QueryDocumentSnapshotAdapter());

  await Hive.openBox('favouritesBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wanderloom',
      theme: ThemeData(
      primaryColor: const Color(0xff2F8D46),
      splashColor: Colors.transparent, 
      highlightColor: Colors.transparent, 
      hoverColor: Colors.transparent,
      fontFamily: 'Poppins'
      ),
      home: const Splashscreen(),
    );
  }
}