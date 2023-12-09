import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    required this.maintext,
    required this.snackbartext,
    required this.function,
    required this.yestext,
    required this.notext,
    Key? key,
  }) : super(key: key);

  final String maintext;
  final String snackbartext;
  final VoidCallback function;
  final String yestext;
  final String notext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        maintext,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      actions: [
        TextButton(
          onPressed: () {
            function(); // Call the function directly
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(snackbartext)),
            );
            Navigator.of(context).pop();
          },
          child: Text(
            yestext,
            style: const TextStyle(color: Color.fromARGB(255, 190, 255, 0)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            notext,
            style: const TextStyle(color: Color.fromARGB(255, 190, 255, 0)),
          ),
        ),
      ],
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),
    );
  }
}
