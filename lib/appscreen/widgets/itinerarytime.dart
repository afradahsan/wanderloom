import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rich_readmore/rich_readmore.dart';


class Itinerarytime extends StatelessWidget {
  final String itntime;
  final String itnlocation;
  final String itndescription;

  const Itinerarytime({
    required this.itntime,
    required this.itnlocation,
    required this.itndescription,
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
                  height: 45,
                  width: 200,
                  child: RichReadMoreText.fromString(text: itndescription,textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(142, 255, 255, 255)), settings: LineModeSettings(
                    trimLines: 1,
                    trimCollapsedText: '...Show more',
                    trimExpandedText: ' Show less',
                    // lessStyle: actionTextStyle,
                    // moreStyle: actionTextStyle,
                    onPressReadMore: () {
                      /// specific method to be called on press to show more
                    },
                    onPressReadLess: () {
                      /// specific method to be called on press to show less
                    },
                  ),
                ),

                  // child: Text(itndescription, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(142, 255, 255, 255)),
                  // ),
                ),
                const Text("www.instagram.com/techxplained_", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(142, 255, 255, 255)),
                ),
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
