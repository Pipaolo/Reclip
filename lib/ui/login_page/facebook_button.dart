import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/core/reclip_colors.dart';

class FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: facebookBlue,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Icon(
        FontAwesomeIcons.facebookF,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}
