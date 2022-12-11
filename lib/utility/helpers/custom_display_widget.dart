import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDisplayWidget {
  // on Error widget
  static onErrorDialogBox(
      BuildContext context, String? msg, String? contentMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Expanded(
          child: Text(
            msg ?? 'Error',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        content: Text(
          contentMessage ?? 'An Error occured',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

  //  message snackbar
  static displaySnackBar(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? '',
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
