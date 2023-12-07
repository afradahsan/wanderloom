import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/adminscreens/addadmin.dart';
import 'package:wanderloom/appscreen/adminscreens/addcategorypage.dart';
import 'package:wanderloom/appscreen/adminscreens/addregion.dart';
import 'package:wanderloom/appscreen/screens/explore_page.dart';
import 'package:wanderloom/appscreen/widgets/floatingbutton.dart';
import 'package:wanderloom/auth/screens/loginpage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        bottom: 20,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AdminAddPage(),
            ),
          );
        },
      ),
      backgroundColor:const Color.fromRGBO(21, 24, 43, 1),
      appBar: PreferredSize(
        preferredSize: const Size(30,40),
        child: BackdropFilter(
          filter: ImageFilter.blur(),
          child: AppBar(          
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(icon: const Icon(Icons.logout), onPressed: (){Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){return const LoginPage();}), (route) => false);},),
              
            )
          ],),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                const Text('Welcome, Admin!', style: TextStyle(color: Color.fromARGB(255, 190, 255, 0)),),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const ExplorePage();
                  }));
                }, child: const Text('Explore')),
                const SizedBox(height: 230,),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const AddCategoryPage();
                  }));
                }, child: const Text('Add Category')),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const AddRegion();
                  }));
                }, child: const Text('Add Region'))
              ],
            ),
            
          ),
        ],
      ),
    );
  }
}