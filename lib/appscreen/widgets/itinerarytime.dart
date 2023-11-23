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
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Color.fromARGB(255, 190, 255, 0), size: 16),
                    Text(itnlocation, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  width: 255,
                  child: ReadMoreText(
                    itndescription,
                    trimLines: 1,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(142, 255, 255, 255))
                  ),
                ),
                Container(
                  width: 255,
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
                     TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 64, 144, 255), overflow: TextOverflow.ellipsis,),
                     
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
