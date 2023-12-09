import 'package:flutter/material.dart';
import 'package:wanderloom/appscreen/widgets/delete_dialog.dart';
import 'package:wanderloom/db/functions/database_services.dart';

class DeleteContainer extends StatelessWidget {
  const DeleteContainer({
    required this.callbackFunction,
    Key? key,
  }) : super(key: key);

  final VoidCallback callbackFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 190, 255, 0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DeleteDialog(
                maintext: 'Are you sure you want to delete?',
                snackbartext: 'Deleted Successfully!',
                function: callbackFunction,
                yestext: 'Yes',
                notext: 'No',
              );
            },
          );
        },
        icon: const Icon(Icons.delete, color: Colors.white),
        label: const Text(
          'Delete',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
