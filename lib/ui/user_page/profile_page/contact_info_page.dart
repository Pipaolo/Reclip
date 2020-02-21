import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_user.dart';

class ContactInfoPage extends StatelessWidget {
  final ReclipUser user;
  const ContactInfoPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 18,
      ),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: ListView(
          children: <Widget>[
            ContactInfo(
              title: 'Email',
              content: user.email,
            ),
            ContactInfo(
              title: 'Mobile Number',
              content: user.contactNumber,
            ),
            ContactInfo(
              title: 'Facebook',
              content: user.facebook,
            ),
            ContactInfo(
              title: 'Twitter',
              content: user.twitter,
            ),
            ContactInfo(
              title: 'Instagram',
              content: user.instagram,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  final String title;
  final String content;

  const ContactInfo({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            title,
            style: TextStyle(
                color: reclipIndigo, fontSize: ScreenUtil().setSp(12)),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: reclipIndigo, width: 1),
              ),
            ),
            child: AutoSizeText(
              content,
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(14)),
            ),
          ),
        ],
      ),
    );
  }
}
