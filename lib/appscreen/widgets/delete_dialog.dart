import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({
    required this.maintext,
    required this.snackbartext,
    required this.function,
    required this.yestext,
    required this.notext,
    super.key
  });

  final String maintext;
  final Future function;
  final String snackbartext;
  final String yestext;
  final String notext;

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.maintext, style: TextStyle(color: Colors.white, fontSize: 18),),
      actions: [
      TextButton(onPressed: (){widget.function.then((value){
      SnackBar(content: (Text(widget.snackbartext)));});
      Navigator.of(context).pop();
      Navigator.of(context).pop();}, 
      child: Text(widget.yestext, style: TextStyle(color: Color.fromARGB(255, 190, 255, 0)),)),
      TextButton(onPressed: (){Navigator.of(context).pop();}, 
      child: Text(widget.notext,style: TextStyle(color: Color.fromARGB(255, 190, 255, 0)),))],
      backgroundColor: const Color.fromRGBO(21, 24, 43, 1),);
  }
}