// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderloom/appscreen/adminscreens/adminpage.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/db/functions/adm_database_services.dart';

class AddRegion extends StatefulWidget {
  const AddRegion({super.key});

  @override
  State<AddRegion> createState() => _AddRegionState();
}

class _AddRegionState extends State<AddRegion> {

    TextEditingController regionController =  TextEditingController();
  var divider = SizedBox(height: 10,);
  XFile? image;
  final imagePicker = ImagePicker();
  String? imageURL;
  String? region;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.white,
                        ),
                        const Text(
                          'Add new Region',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onSave();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 190, 255, 0)),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Color.fromRGBO(21, 24, 43, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                    divider,
                    divider,
                    const Text('Add Image:' ,style: TextStyle(color: Color.fromARGB(255, 190, 255, 0),),),
                    const SizedBox(height: 5,),
                    ImageUpload(),
                    divider,
                    divider,
                    Textfeildtrip(
                      addtripController: regionController,
                      textformlabel: "Region Name",
                      textformhinttext: 'Imp Contacts',
                      textformIconPrefix: Icons.category,
                    ),
                    divider,
                    divider,
          ])
          ))
          )
    );
  }
   ImageUpload(){
    return Container(
      height: 150,
      width: 330,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10)
      ),
      child: image==null ? IconButton(onPressed: (){
        ImagePickerMethod();
      }, icon: const Icon(Icons.add,size: 50,color: Color.fromARGB(255, 190, 255, 0),)) 
      : Image.file(File(image!.path)),
    );
  }

  Future ImagePickerMethod() async{
    XFile? imagefile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(imagefile==null){
        print("error!");
      }
      else{
        // print('${imagefile!.path}');
      image = XFile(imagefile.path);
      }
    });

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    //Creating a reference to the file.
    Reference ref = FirebaseStorage.instance.ref().child('region').child(fileName);

    try{    
    //Adding the file to the storage.
    await ref.putFile(File(imagefile!.path));
    imageURL = await ref.getDownloadURL();
    print(imageURL);
    }
    catch(error){
      print(error);
    }
  }

  Future onSave() async{
    if(imageURL!=null && regionController.text.isNotEmpty)
    {
    await ImagePickerMethod();
    await AdminDatabase().addRegion(imageURL, regionController.text.toString());

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return AdminPage();
    }));
    }
  }
}