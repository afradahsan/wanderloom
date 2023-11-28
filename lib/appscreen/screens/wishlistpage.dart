import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/widgets/place_listtile.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 24, 43, 1),
      appBar: AppBar(title: Text('Your Wishlist!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0,),
      body: SafeArea(child: Column(
        children: [
          
        ],
      )),
    );
  }
}