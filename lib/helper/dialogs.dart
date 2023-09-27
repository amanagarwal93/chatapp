import 'package:flutter/material.dart';

class Dialogs {
  // show snack bar
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.blue.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
    ));
  }

  // show progress dialog
  static void showProgressBar(
    BuildContext context,
  ) {
    showDialog(context: context, builder: (_) => CircularProgressIndicator());
  }
}
