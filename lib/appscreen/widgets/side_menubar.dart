import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/screens/budget_page.dart';
import 'package:wanderloom/appscreen/screens/itinerary_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.6,
        child: Drawer(
          
          backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  Container(
                    decoration: BoxDecoration(color: const Color.fromARGB(53, 255, 255, 255), borderRadius: BorderRadius.circular(12),),
                    child: ListTile(
                              title: const Text('Itinerary', style: TextStyle(color: Colors.white),),
                              leading: const Icon(Icons.table_chart_rounded, color: Colors.white,),
                              minLeadingWidth: 10,
                              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return const ItineraryPage(tripId: '',);
                                }));
                              },
                            )
                  ),
                           ListTile(
                            title: const Text('Budget', style: TextStyle(color: Colors.white),),
                            leading: const Icon(Icons.attach_money_rounded, color: Colors.white,),
                            minLeadingWidth: 10,
                            onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return const BudgetPage();
                                }));
                              },
                          ),
                      
                          const ListTile(
                            title: Text('Backpack', style: TextStyle(color: Colors.white),),
                            leading: Icon(Icons.backpack_rounded, color: Colors.white,),
                            minLeadingWidth: 10
                          ),const ListTile(
                            title: Text('Reminder', style: TextStyle(color: Colors.white),),
                            leading: Icon(Icons.circle_notifications_rounded, color: Colors.white,),
                            minLeadingWidth: 10
                          ),
                          const ListTile(
                            title: Text('Notes', style: TextStyle(color: Colors.white),),
                            leading: Icon(Icons.menu_book_rounded, color: Colors.white,),
                            minLeadingWidth: 10
                          ),
                  
                ],
              ),
            ),
          
        ),
      ),
    );
  }
}