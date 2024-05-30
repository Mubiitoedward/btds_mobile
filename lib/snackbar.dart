import 'package:flutter/material.dart';

class Snackbar {
  void displaymessage(BuildContext context, String message, bool success) {
    final Snackbar = SnackBar(
        dismissDirection: DismissDirection.up,
        duration: Duration(milliseconds: 800),
        // margin:
        //     EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 140),
        content: Row(
          children: [
            success
                ? Icon(Icons.check, color: Colors.white)
                : Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Wrap(children: [
              Text(
                message,
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.fade,
              )
            ])),
          ],
        ),
        backgroundColor: success
            ? Color.fromARGB(255, 19, 175, 24)
            : Color.fromARGB(255, 236, 31, 16));
    ScaffoldMessenger.of(context).showSnackBar(Snackbar);
  }
}
