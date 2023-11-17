import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsPage extends StatefulWidget {

  PlaceDetailsPage({
    required this.doc, required this.placeID, super.key});

  dynamic doc;
  String? placeID;

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final divider = SizedBox(height: screenHeight/80,);
    double ten = screenHeight/80;
    double twenty = screenHeight/40;
    print(screenHeight);
    print("width: $screenWidth");

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async{
      const url = 'https://www.google.com/maps/place/Bada+Bagh/@26.9551143,70.8877216,15z/data=!4m6!3m5!1s0x3947be19bfbede2b:0x46e746e381489828!8m2!3d26.9551143!4d70.8877216!16s%2Fm%2F02q8w_1?entry=ttu';
      launchUrl(Uri.parse(url)).onError(
        (error, stackTrace) {
          print("Url is not valid!");
          return false;
        },
        
      );
      },
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Color.fromARGB(255, 190, 255, 0),
      child: Image.asset('assets/images/navigation_3d.png', height: 25,),),
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(twenty-2,twenty,twenty-2,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight/3.5, 
                  width: screenWidth-36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(10),
                      child: Image.network(widget.doc['Image URL'],height: double.infinity, width: double.infinity, fit: BoxFit.cover),),
                      Positioned(
                        left: ten/2,
                        top: ten/2,
                        child: IconButton(icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, color: Colors.white,)),
                    ],
                  ),
                  ),
                divider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.doc['Place Name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: twenty+6),),
                    const Icon(Icons.bookmark_border_rounded, color: Colors.white,)
                  ],
                ),
                divider,

                ReadMoreText(
                ' ${widget.doc['Place Description']}',
                trimLines: 5,
                style: TextStyle(color: const Color.fromARGB(180, 255, 255, 255), fontSize: ten+4,)
                ),
                divider,
                divider,
                Row(
                  children: [
                    Container(
                      height: ten*4,
                      width: ten*4,
                      decoration: BoxDecoration(color: const Color.fromARGB(128, 255, 255, 255), borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.5),spreadRadius: 2,blurRadius: 7,offset: const Offset(3, 3),
                        ),
                      ]),
                      child: Image.asset('assets/images/star_3d.png'),
                    ),SizedBox(width: ten/2,),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('4.4',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ten+4),),
                            Icon(Icons.star, color: Colors.white,size: ten+5,),
                          ],
                        ),
                        Text('8 ratings',
                        style: TextStyle(decoration: TextDecoration.underline, color: Color.fromARGB(180, 255, 255, 255), fontSize: ten+2,))
                      ],
                    ),
                    SizedBox(width: ten*7,),
                    Container(
                      height: ten*4,
                      width: ten*4,
                      decoration: BoxDecoration(color: const Color.fromARGB(128, 255, 255, 255), borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.5),spreadRadius: 2,blurRadius: 7,offset: const Offset(3, 3),
                        ),
                      ]),
                      child: Image.asset('assets/images/star_3d.png')),
                      SizedBox(width: ten/2,),
                      Text('15-26°C', style: TextStyle(color: Colors.white, fontSize: ten+8, fontWeight: FontWeight.w500),)
                  ],
                ),
                
                divider,divider,
                Text('Best time to visit:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: twenty-3)),
                divider,
                Container(
                  height: ten*3.5,
                  width: ten*16,
                  decoration: BoxDecoration(color: const Color.fromARGB(105, 207, 207, 207), borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.5),spreadRadius: 2,blurRadius: 7,offset: const Offset(3, 3),
                    ),
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month_rounded, color: Colors.white,size: twenty-2),
                      SizedBox(width: ten/2,),
                      Text('October - March', style: TextStyle(color: const Color.fromARGB(255, 250, 215, 27), fontWeight: FontWeight.w600, fontSize: ten+4, )),
                    ],
                  ),
                  ),
                divider,
                Text('The best time to visit Bada Bagh, is during winter, from October to March. This period offers the most pleasant weather for exploring the historical site comfortably.' , style: TextStyle(color: Color.fromARGB(190, 255, 255, 255), fontWeight: FontWeight.w500, fontSize: ten+2)),
                divider,
                Text('Entry Fee:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: twenty-3)),
                SizedBox(height: ten/2,),
                Row(children: [Icon(Icons.circle, size: 7, color: Colors.white,),
                SizedBox(width: ten/2,),
                Text('Indian - ₹50', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ten+3)),
                ],),
                Row(children: [Icon(Icons.circle, size: 7, color: Colors.white,),
                SizedBox(width: ten/2,),
                Text('Foreigner - ₹100', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ten+3)),
                ],),
                divider,
                Text('How to reach?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: twenty-3)),
                SizedBox(height: ten/2,),
                Text('Bada Bagh is located at 6KM from the railway station of Jaisalmer as well as the city center. There are regular bus services to transfer you between Ramgarh bus station and Bada Bagh, Jaisalmer.' , style: TextStyle(color: Color.fromARGB(190, 255, 255, 255), fontWeight: FontWeight.w500, fontSize: ten+2)),
              ],
            ),
          )
        ),
      ),
    );
  }
}