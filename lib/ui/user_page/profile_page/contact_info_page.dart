import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_user.dart';

class ContactInfoPage extends StatelessWidget {
  final ReclipUser user;
  const ContactInfoPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: reclipIndigoDark,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              'Mobile Number: ${user.contactNumber}',
              maxLines: 8,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            AutoSizeText(
              'Email: ${user.email}',
              maxLines: 8,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
