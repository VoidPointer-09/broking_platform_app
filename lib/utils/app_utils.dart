import 'package:flutter/material.dart';

class AppUtils{
  void showSnackBar({String? message, Color? backgroundColor, required BuildContext context}) {
    final snackBar = SnackBar(
      content: Text(
        message ?? "",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      action: SnackBarAction(
        label: 'CLOSE',
        textColor: Colors.white,
        onPressed: () {
          // Some code to execute.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}