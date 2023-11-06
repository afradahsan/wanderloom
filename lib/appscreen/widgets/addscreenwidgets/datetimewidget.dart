import 'package:flutter/material.dart';

class PickDateTime extends StatefulWidget {
  const PickDateTime({super.key});

  @override
  State<PickDateTime> createState() => _PickDateTimeState();
}

class _PickDateTimeState extends State<PickDateTime> {
  DateTimeRange dtRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  Widget build(BuildContext context) {
    final start = dtRange.start;
    final end = dtRange.end;
    return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const Row(
            children: [
              Icon(Icons.calendar_month_rounded, size: 12, color: Color.fromARGB(255, 190,255, 0),),
              SizedBox(width: 5,),
              Text('Start Date', style: TextStyle(color: Color.fromARGB(255, 190,255, 0), fontSize: 12),),
            ],
          ),

          TextButton(style: TextButton.styleFrom(side: const BorderSide(width: 1, color: Colors.white)), onPressed: (){
            pickDateRange(context);
          },child: Text('${start.day}/${start.month}/${start.year}', style: const TextStyle(color: Colors.white, fontSize: 15 )),),
        ],
      ),
      
      const SizedBox(width: 30),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_month_rounded, size: 12, color: Color.fromARGB(255, 190,255, 0),),
              SizedBox(width: 5,),
              Text('End Date', style: TextStyle(color: Color.fromARGB(255, 190,255, 0), fontSize: 12),),
            ],
          ),

          TextButton(style: TextButton.styleFrom(side: const BorderSide(width: 1, color: Colors.white)), onPressed: (){
            
          },child: Text('${end.day}/${end.month}/${end.year}', style: const TextStyle(color: Colors.white)),),
        ],
      ),
    ],
    );
  }
    Future pickDateRange(BuildContext context) async{
    DateTimeRange? newdateRange = await showDateRangePicker(
      context: context, firstDate: DateTime(1950), lastDate: DateTime(2100), initialDateRange: dtRange);
    
    if(newdateRange == null) return;

    setState(() {
      dtRange = newdateRange;
    });
  }
}