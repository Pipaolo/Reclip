import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarCollection {
  FlushbarCollection._();

  static void showFlushbarDevelopment(String notice, BuildContext context) {
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 20,
      duration: Duration(seconds: 3),
      titleText: Text(
        (notice.isEmpty) ? notice : '👷‍♂️🛠 Under Construction ⚒👷‍♀️',
        style: TextStyle(color: Colors.blue),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      messageText: Text(
        'Our developers our currently working on this feature. Sorry for the inconvenience.',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    )..show(context);
  }
}
