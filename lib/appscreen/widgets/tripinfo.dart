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
   required  this.categoryName,
   required  this.tripTitle,
   required  this.tripDate,
   required  this.tripBudget,
   required  this.tripPeople,
   required this.catContWidth,
   required this.returnParameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return ItineraryPage(tripId: returnParameter!);
      }));
      print('return Parameter $returnParameter');
      },
      child: Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      width: 390,
      decoration: const BoxDecoration(
        color: Color.fromARGB(26, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Container(
      height: 25,
      
      width: catContWidth,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 190,255, 0),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(categoryIcon!, height: 18,),
          const SizedBox(width: 2,),
          Text(categoryName!, style: const TextStyle(fontWeight: FontWeight.w600),),
        ],
      ),
      ),
      const SizedBox(height: 7,),
      Text(tripTitle!, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600)),
      const SizedBox(height: 7,),
      Text( tripDate!, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
      const SizedBox(height: 7,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/money-with-wings_emoji_1f4b8.png', height: 20,),
          const SizedBox(width: 8,),
          Text(tripBudget!,style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500))
        ],
      ),
      const SizedBox(height: 7,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center   ,
        children: [
          Image.asset('assets/icons/people_team_icon.png', height: 20,),
          const SizedBox(width: 8,),
          Text(tripPeople!,style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500))
        ],
      ),
      const SizedBox(height: 10,),
        ],
      ),
      ),
    );
  }
}