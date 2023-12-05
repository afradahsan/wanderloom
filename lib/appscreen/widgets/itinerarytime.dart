import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:url_launcher/url_launcher.dart';


class Itinerarytime extends StatelessWidget {
  final String itntime;
  final String itnlocation;
  final String itndescription;
  final String? itnLink;

  Itinerarytime({super.key, 
    required this.itntime,
    required this.itnlocation,
    required this.itndescription,
    this.itnLink,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    final time = parseTime(itntime);

    String formattedTime = formatTimeOfDay(time);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedTime,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
            SizedBox(width: screenHeight/80,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Color.fromARGB(255, 190, 255, 0), size: screenHeight/50,),
                    Text(itnlocation, style: TextStyle(fontSize: screenHeight/50, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenHeight/4,
                  child: ReadMoreText(
                    itndescription,
                    trimLines: 1,
                    style: TextStyle(fontSize: screenHeight/66.66, fontWeight: FontWeight.w500, color: const Color.fromARGB(142, 255, 255, 255))
                  ),
                ),
                Container(
                  width: screenHeight/4,
                  child: GestureDetector(
                    onTap: () {
                      final url = itnLink;
                      launchUrl(Uri.parse(url ?? '')).onError(
                        (error, stackTrace) {
                          print("Url is not valid!");
                          return false;
                        },
                      );
                    },
                    child: Text(itnLink ?? '', style:
                     TextStyle(fontSize: screenHeight/66.66, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 64, 144, 255)),
                     overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 5,)
              ],
            ),
          ],
        ),
      ],
    );
  }

  TimeOfDay parseTime(String timeString) {
    final parts = timeString.split('(')[1].split(')')[0].split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }
}
