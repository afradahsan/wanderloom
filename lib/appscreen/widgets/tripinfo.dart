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
    double ten = screenHeight/(0.10*screenHeight);
    double twenty = screenWidth/(0.05*screenWidth);

    print('$screenWidth, $screenHeight, $ten, $twenty');
    final divider = SizedBox(height: ten);


    return GestureDetector(
      onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return ItineraryPage(tripId: returnParameter!, triptitle: tripTitle,);
      }));
      print('return Parameter $returnParameter');
      },
      child: Container(
      padding: EdgeInsets.all(ten*1.5),
      height: ten*20.5,
      width: ten*39,
      decoration: BoxDecoration(
        color: const Color.fromARGB(26, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(ten))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Container(
      height: ten*2.5,
      width: catContWidth,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 190,255, 0),
        borderRadius: BorderRadius.all(Radius.circular(twenty))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(categoryIcon!, height: ten*1.8,),
          SizedBox(width: ten*0.2,),
          Text(categoryName!, style: const TextStyle(fontWeight: FontWeight.w600),),
        ],
      ),
      ),
      SizedBox(height: ten*0.7,),
      Text(tripTitle!, style: TextStyle(color: Colors.white, fontSize: ten*2.6, fontWeight: FontWeight.w600)),
      SizedBox(height: ten*0.7,),
      Text( tripDate!, style: TextStyle(color: Colors.white, fontSize: ten*1.6, fontWeight: FontWeight.w500)),
      SizedBox(height: ten*0.7,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/money-with-wings_emoji_1f4b8.png', height: ten*2,),
          SizedBox(width: ten*0.8,),
          Text(tripBudget!,style: TextStyle(color: Colors.white, fontSize: ten*1.6, fontWeight: FontWeight.w500))
        ],
      ),
      SizedBox(height: ten*0.7,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center   ,
        children: [
          Image.asset('assets/icons/people_team_icon.png', height: ten*2,),
          SizedBox(width: ten*0.8,),
          Text(tripPeople!,style: TextStyle(color: Colors.white, fontSize: ten*1.6, fontWeight: FontWeight.w500))
        ],
      ),
      SizedBox(height: ten,),
        ],
      ),
      ),
    );
  }
}