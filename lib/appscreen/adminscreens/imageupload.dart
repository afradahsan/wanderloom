// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageUpload extends StatefulWidget {
//   const ImageUpload({super.key});

//   @override
//   State<ImageUpload> createState() => _ImageUploadState();
// }

// class _ImageUploadState extends State<ImageUpload> {



//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       width: 330,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.white),
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(10)
//       ),
//       child: image==null ? IconButton(onPressed: (){
//         ImagePickerMethod();
//       }, icon: const Icon(Icons.add,size: 50,color: Color.fromARGB(255, 190, 255, 0),)) 
//       : Image.file(image!),
//     );
//   }

//   Future ImagePickerMethod() async{
//     final imagefile = await imagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if(imagefile!=null){
//       image = File(imagefile.path);
//       }
//       else{
//         print("error!");
//       }
//     });
//   }

//   Future uploadToStorage() async{
//     Reference ref = FirebaseStorage.instance.ref().child('places');
//     await ref.putFile(image!);
//     downloadURL = await ref.getDownloadURL();
//     print(downloadURL);
//   }
// }