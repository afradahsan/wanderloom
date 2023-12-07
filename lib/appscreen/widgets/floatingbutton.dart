import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final Function onPressed;
  final double bottom;

  const FloatingButton({super.key, 
    required this.onPressed,
    required this.bottom
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: bottom,
          right: 0,
          child: FloatingActionButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), onPressed: () {
              onPressed();  // Invoke the provided onPressed function
            }, backgroundColor: const Color.fromARGB(255, 190,255, 0),
          child: const Icon(Icons.add, color: Color.fromRGBO(21, 24, 43, 1)),),
        ),
      ],
    );
  }
}