import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderloom/appscreen/adminscreens/imageupload.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/appscreen/widgets/dropdown.dart';
import 'package:wanderloom/appscreen/widgets/dropdown_place.dart';

class AdminAddPage extends StatefulWidget {
  const AdminAddPage({super.key});

  @override
  State<AdminAddPage> createState() => _AdminAddPageState();
}

class _AdminAddPageState extends State<AdminAddPage> {

  final divider = SizedBox(height: 10,);
  TextEditingController placeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? image;
  final imagePicker = ImagePicker();
  String? downloadURL;

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
                            'Add new Place',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              uploadToStorage();
                              
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
                      DropDownWidget(),
                      divider,
                      divider,
                      DropDownPlaceWidget(),
                      divider,
                      Textfeildtrip(
                        addtripController: placeController,
                        textformlabel: "Place Name",
                        textformhinttext: 'Imp Contacts',
                        textformIconPrefix: Icons.title,
                      ),
                      divider,
                      divider,
                      Textfeildtrip(
                        maxLines: 10,
                        addtripController: descriptionController,
                        textformlabel: "Description",
                        textformhinttext: 'Agra Auto Contact No: ',
                        textformIconPrefix: Icons.description,
                      ),
            ])
            ))
            ));
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
      : Image.file(image!),
    );
  }

  Future ImagePickerMethod() async{
    final imagefile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(imagefile!=null){
      image = File(imagefile.path);
      }
      else{
        print("error!");
      }
    });
  }

  Future uploadToStorage() async{
    Reference ref = FirebaseStorage.instance.ref().child('places');
    await ref.putFile(image!);
    downloadURL = await ref.getDownloadURL();
    print(downloadURL);
  }
}