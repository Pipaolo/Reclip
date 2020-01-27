import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Icon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
      onPressed: () {},
    );
  }
}
