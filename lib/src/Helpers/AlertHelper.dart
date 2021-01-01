import 'package:flutter/material.dart';

class AlertHelper {
  static showLoadingDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (comtext) {
          return Dialog(
            child: Container(
              height: 90,
              width: 450,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 30),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(width: 30),
                  Text(
                    "Loading...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        });
  }
}
