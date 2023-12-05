// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/itinerary_page.dart';

class TripInfo extends StatelessWidget {
  
  final String? categoryIcon;
  final String? categoryName;
  final String? tripTitle;
  final String? tripDate;
  final String? tripBudget;
  final String? tripPeople;
  final double? catContWidth;
  String? returnParameter;

  TripInfo({super.key, 
   required this.categoryIcon,
   required this.categoryName,
   required this.tripTitle,
   required this.tripDate,
   required this.tripBudget,
   required this.tripPeople,
   required this.catContWidth,
   required this.returnParameter
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    Widget wdivider = SizedBox(width: screenHeight/130,);


    print('$screenWidth, $screenHeight');


    return GestureDetector(
      onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return ItineraryPage(tripId: returnParameter!, triptitle: tripTitle,);
      }));
      print('return Parameter $returnParameter');
      },
      child: Container(
      padding: EdgeInsets.all(15),
      height: screenHeight/3.9,
      width: screenHeight/2.05,
      decoration: BoxDecoration(
        color: const Color.fromARGB(26, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Container(
      height: screenHeight/31,
      width: catContWidth,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 190,255, 0),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(categoryIcon!, height: screenHeight/44.4,),
          const SizedBox(width: 2),
          Text(categoryName!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenHeight/57),),
        ],
      ),
      ),
      SizedBox(height: screenHeight/114.28,),
      Text(tripTitle!, style: TextStyle(color: Colors.white, fontSize: screenHeight/30.7, fontWeight: FontWeight.w600)),
      SizedBox(height: screenHeight/114.28,),
      Text( tripDate!, style: TextStyle(color: Colors.white, fontSize: screenHeight/50, fontWeight: FontWeight.w500)),
      SizedBox(height: screenHeight/114.28,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/money-with-wings_emoji_1f4b8.png', height: screenHeight/40,),
          SizedBox(width: screenHeight/114.28,),
          Text(tripBudget!,style: TextStyle(color: Colors.white, fontSize: screenHeight/50, fontWeight: FontWeight.w500))
        ],
      ),
      SizedBox(height: screenHeight/114.28,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center   ,
        children: [
          Image.asset('assets/icons/people_team_icon.png', height: screenHeight/40,),
          SizedBox(width: screenHeight/100,),
          Text(tripPeople!,style: TextStyle(color: Colors.white, fontSize: screenHeight/50, fontWeight: FontWeight.w500))
        ],
      ),
      // SizedBox(height: screenHeight/80,),
        ],
      ),
      ),
    );
  }
}