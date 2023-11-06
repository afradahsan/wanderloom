import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final Function onPressed;

  const FloatingButton({super.key, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), onPressed: () {
        onPressed();  // Invoke the provided onPressed function
      }, backgroundColor: const Color.fromARGB(255, 190,255, 0),
    child: const Icon(Icons.add, color: Color.fromRGBO(21, 24, 43, 1)),);
  }
}