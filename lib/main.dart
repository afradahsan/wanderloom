import 'package:flutter/material.dart';
import 'package:wanderloom/auth/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Hive.initFlutter();
  // Hive.registerAdapter(TripDetailsModelAdapter());
  // Hive.registerAdapter(UserModelAdapter());

  // await Hive.openBox<UserModel>('signup_db');
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