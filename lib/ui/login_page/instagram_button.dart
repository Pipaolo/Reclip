import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/core/reclip_colors.dart';

class InstagramButton extends StatelessWidget {
  const InstagramButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(2),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: instagramColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.05, 0.40, 0.65, 0.80, 1.0],
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: InkWell(
          splashColor: Colors.black38,
          highlightColor: Colors.black45,
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.09,
                vertical: 6),
            child: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
