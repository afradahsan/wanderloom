import 'package:flutter/material.dart';

class Itinerarytime extends StatelessWidget {

  final String itntime;
  final String itnlocation;
  final String itndescription;
  // final String? url;


  const Itinerarytime({super.key, 
    required this.itntime,
    required this.itnlocation,
    required this.itndescription,
  }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(itntime, style: const TextStyle(fontWeight:FontWeight.w500, color: Colors.white),),
        const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, color: Color.fromARGB(255, 190,255, 0),size: 16,),
                  Text(itnlocation, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
                ],
              ),
              SizedBox(
                height: 45,
                width: 200,
                child: Text(itndescription, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(142, 255, 255, 255)),),
              ),
              const Text("www.instagram.com/techxplained_", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(142, 255, 255, 255)),),
              ],
            )
          ],
        ),
      ],
    );
  }


}

