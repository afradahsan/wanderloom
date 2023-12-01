// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderloom/appscreen/adminscreens/adminpage.dart';
import 'package:wanderloom/appscreen/screens/placedetails.dart';
import 'package:wanderloom/appscreen/widgets/addscreenwidgets/textfieldtrip.dart';
import 'package:wanderloom/appscreen/widgets/dropdown.dart';
import 'package:wanderloom/appscreen/widgets/dropdown_place.dart';
import 'package:wanderloom/db/functions/adm_database_services.dart';

class EditPlaceDetailsPage extends StatefulWidget {
  EditPlaceDetailsPage({required this.doc, required this.placeID,required this.placeName,required this.location,required this.description,required this.weather, required this.bestTime, required this.bestTimeDesc,required this.rateInd, required this.rateFor, required this.howtoReach, required this.navLink, super.key});

  final dynamic doc;
  final String? placeID;
  final String? placeName;
  final String? location;
  final String? description;
  final String? weather;
  final String? bestTime;
  final String? bestTimeDesc;
  final String? rateInd;
  final String? rateFor;
  final String? howtoReach;
  final String? navLink;

  @override
  State<EditPlaceDetailsPage> createState() => _EditPlaceDetailsPageState();
}

class _EditPlaceDetailsPageState extends State<EditPlaceDetailsPage> {

  final divider = SizedBox(height: 10,);
  late TextEditingController placeController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController weatherController ;
  late TextEditingController btvController ;
  late TextEditingController btvDescController ;
  late TextEditingController rateindController; 
  late TextEditingController ratefornController; 
  late TextEditingController hwtoreachController;  
  late TextEditingController navLinkController ;

  XFile? image;
  final imagePicker = ImagePicker();
  String? imageURL;
  String? category;
  String? region;

  @override
  void initState() {
    super.initState();
    placeController = TextEditingController(text: widget.placeName);
    locationController = TextEditingController(text: widget.location);
    descriptionController = TextEditingController(text: widget.description);
    weatherController = TextEditingController(text: widget.weather);
    btvController = TextEditingController(text: widget.bestTime);
    btvDescController = TextEditingController(text: widget.bestTimeDesc);
    rateindController = TextEditingController(text: widget.rateInd);
    ratefornController = TextEditingController(text: widget.rateFor);
    hwtoreachController = TextEditingController(text: widget.howtoReach);
    navLinkController = TextEditingController(text: widget.navLink);
  }
  
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
                            onSave();
                            print('onsave');
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
                    DropDownWidget(onValueChanged: (value) {
                      setState(() {
                        category = value;
                      });
                      print('Place Category: $value');
                    },),
                    divider,
                    divider,
                    DropDownPlaceWidget(onValChanged: (value) {
                      setState(() {
                        region = value;
                      });
                      print('region == $region');
                    },),
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
                      addtripController: locationController,
                      textformlabel: "Location",
                      textformhinttext: 'Agra Auto Contact No: ',
                      textformIconPrefix: Icons.location_on,
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
                    divider,
                    divider,
                    Textfeildtrip(
                      addtripController: weatherController,
                      textformlabel: "Weather Range?",
                      textformhinttext: '15-26 C',
                      textformIconPrefix: Icons.sunny,
                    ),
                    divider,
                    divider,
                    Textfeildtrip(
                      addtripController: btvController,
                      textformlabel: "Best time?",
                      textformhinttext: 'October-March',
                      textformIconPrefix: Icons.calendar_month_rounded,
                    ),
                    divider,
                    divider,
                    Textfeildtrip(
                      addtripController: btvDescController,
                      textformlabel: "Best Time Description",
                      textformhinttext: 'Describe',
                      textformIconPrefix: Icons.description,
                    ),
                    divider,
                    divider,
                    Textfeildtrip(
                      addtripController: rateindController,
                      textformlabel: "Indian Rate",
                      textformhinttext: '50',
                      textformIconPrefix: Icons.currency_rupee_rounded,
                    ),
                    divider,
                    divider,
                    Textfeildtrip(
                      addtripController: ratefornController,
                      textformlabel: "Foriegner Rate",
                      textformhinttext: '50',
                      textformIconPrefix: Icons.currency_rupee_rounded,
                    ),
                    divider,
                    divider,
                    Textfeildtrip(
                      addtripController: hwtoreachController,
                      textformlabel: "How to Reach?",
                      textformhinttext: 'October-March',
                      textformIconPrefix: Icons.train,
                    ),
                    divider,
                    divider,
                    Textfeildtrip(
                      addtripController: navLinkController,
                      textformlabel: "Directions",
                      textformhinttext: 'Link',
                      textformIconPrefix: Icons.link_rounded,
                    ),
                    divider
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
    Reference ref = FirebaseStorage.instance.ref().child('places').child(fileName);

    try{    
    //Adding the file to the storage.
    await ref.putFile(File(imagefile!.path));
    imageURL = await ref.getDownloadURL();
    print("imageURL: $imageURL");
    }
    catch(error){
      print("imageURL errro: $error");
    }
    
    //using await for the put to complete.

  }

  Future onSave() async{
    if(placeController.text.toString().isNotEmpty)
    {
      print('passs');
    await ImagePickerMethod();

    await AdminDatabase().updateData(widget.placeID!,imageURL, category, region, placeController.text.toString(), locationController.text.toString(),descriptionController.text.toString(), weatherController.text.toString(),btvController.text.toString(), btvDescController.text.toString(), rateindController.text.toString(), ratefornController.text.toString(),hwtoreachController.text.toString(), navLinkController.text.toString());

    Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      return PlaceDetailsPage(doc: widget.doc, placeID: widget.placeID);
    })));

    }
    else{print('errrorrr');}
  }
}