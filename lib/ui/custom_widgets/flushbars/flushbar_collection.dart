import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/core/reclip_colors.dart';

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

  static void showFlushbarWarning(
      String title, String noticeText, BuildContext context) {
    Flushbar(
      backgroundColor: reclipBlackDark,
      margin: EdgeInsets.all(8),
      borderRadius: 20,
      duration: Duration(seconds: 3),
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.yellow),
          ),
        ],
      ),
      messageText: Text(
        noticeText,
        style: TextStyle(color: Colors.white),
      ),
    )..show(context);
  }

  static void showFlushbarNotice(
      String title, String noticeText, BuildContext context) {
    Flushbar(
      backgroundColor: reclipBlackDark,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: 20,
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
      messageText: Text(
        noticeText,
        style: TextStyle(color: Colors.white),
      ),
      showProgressIndicator: true,
    )..show(context);
  }

  static void showFlushbarSuccess(String successText, BuildContext context) {
    Flushbar(
      backgroundColor: reclipBlackDark,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: 20,
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            successText,
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            FontAwesomeIcons.checkCircle,
            color: Colors.green,
          ),
        ],
      ),
    )..show(context);
  }

  static void showFlushbarError(String errorText, BuildContext context) {
    Flushbar(
      backgroundColor: reclipBlackDark,
      duration: Duration(seconds: 3),
      icon: Icon(
        FontAwesomeIcons.exclamationCircle,
        color: Colors.red,
      ),
      messageText: Text(
        errorText,
        style: TextStyle(color: Colors.white),
      ),
    )..show(context);
  }
}
