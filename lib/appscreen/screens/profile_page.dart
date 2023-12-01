// ignore_for_file: prefer_const_constructors, avoid_print, unused_import

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderloom/appscreen/screens/addscreeens/editprofile.dart';
import 'package:wanderloom/appscreen/screens/searchscreen.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/appscreen/widgets/bottom_navbar.dart';
import 'package:wanderloom/auth/functions/auth_functions.dart';
import 'package:wanderloom/db/functions/adm_database_services.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();

  late TextEditingController usernameController;
  late TextEditingController emailController;

  int selectedIndex = 2;

  final uid = FirebaseAuth.instance.currentUser!.uid;
  XFile? image;
  final imagePicker = ImagePicker();
  String? imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                      ),
                      Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: data['profilepicurl'] == null
                                  ? IconButton(
                                      onPressed: () {
                                        ImagePickerMethod(uid);
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 50,
                                        color: Color.fromARGB(255, 190, 255, 0),
                                      ))
                                  : GestureDetector(
                                      onTap: () {
                                        ImagePickerMethod(uid);
                                      },
                                      child: Image.network(
                                        data['profilepicurl'],
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 80,
                                      ),
                                    )),
                          const Positioned(
                              bottom: 0,
                              right: 0,
                              child: Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                                size: 20,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            data['userName'],
                            style: TextStyle(
                                color: Color.fromARGB(255, 190, 255, 0),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          Text(
                            data['email'],
                            style: TextStyle(
                                color: Color.fromARGB(88, 255, 255, 255),
                                fontWeight: FontWeight.w300,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      ListTile(
                        title: const Text(
                          'Edit Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        leading: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(198, 255, 255, 255),
                        ),
                        minLeadingWidth: 15,
                        onTap: () {
                          setState(() {
                           usernameController = TextEditingController(text: data['userName']);
                           emailController = TextEditingController(text: data['email']);
                          });
                          _showAlertDialog();
                          
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'Location & Permissions',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        leading: const Icon(
                          Icons.settings,
                          color: Color.fromARGB(198, 255, 255, 255),
                        ),
                        minLeadingWidth: 15,
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const SearchScreen();
                          }));
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'Help & Support',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        leading: const Icon(
                          Icons.support_agent,
                          color: Color.fromARGB(198, 255, 255, 255),
                        ),
                        minLeadingWidth: 15,
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const SearchScreen();
                          }));
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'Log Out',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        leading: const Icon(
                          Icons.logout,
                          color: Color.fromARGB(198, 255, 255, 255),
                        ),
                        minLeadingWidth: 15,
                        onTap: () {
                          authService.signOut(context);
                        },
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.logout_outlined),
                      //   color: Colors.white,
                      //   onPressed: () {
                      //     authService.signOut(context);
                      //   },
                      // ),
                    ]);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future ImagePickerMethod(userId) async {
    XFile? imagefile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (imagefile == null) {
        print("error!");
      } else {
        // print('${imagefile!.path}');
        image = XFile(imagefile.path);
      }
    });

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    //Creating a reference to the file.
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('userProfilePictures/$userId/profilePicture.jpg')
        .child('profilepic.jpg');

    try {
      //Adding the file to the storage.
      await ref.putFile(File(imagefile!.path));
      imageURL = await ref.getDownloadURL();
      print(imageURL);

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid!)
          .set({'profilepicurl': imageURL}, SetOptions(merge: true));
    } catch (error) {
      print(error);
    }
  }

  _showAlertDialog(){
    return showDialog(context: context, builder: (context){
      print('object: $usernameController');
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        title: Text('Edit Details:', style: TextStyle(color: Color.fromARGB(255, 190,255, 0)),),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Textfeildtrip(textformlabel: 'Username', textformhinttext: '', textformIconPrefix: Icons.person,
              addtripController: usernameController,),
              SizedBox(height: 20,),
              Textfeildtrip(textformlabel: 'Email', textformhinttext: '', textformIconPrefix: Icons.email,
              addtripController: emailController,
              maxLines: 1,),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('Cancel', style: TextStyle(color: Color.fromARGB(255, 190,255, 0)),)),
          ElevatedButton(onPressed: (){
            updateUser(usernameController.text.toString(), emailController.text.toString());
            Navigator.of(context).pop();
          }, child: Text('Save', style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 190,255, 0)),),
        ],
      );
    });
  }

  Future updateUser(String username, String email) async{
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'userName': username,
      'email': email,
    });
  }
}
