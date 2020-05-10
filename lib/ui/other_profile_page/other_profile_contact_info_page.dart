import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherProfileContactInfoPage extends StatelessWidget {
  final ReclipContentCreator user;
  const OtherProfileContactInfoPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
      alignment: Alignment.center,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UserContactInfo(
                title: 'Email',
                content: user.email,
              ),
              UserContactInfo(
                title: 'Mobile Number',
                content: user.contactNumber,
              ),
              if (user.facebook.isNotEmpty && user.facebook != null)
                UserContactInfo(
                  title: 'Facebook',
                  content: user.facebook,
                ),
              if (user.twitter.isNotEmpty && user.twitter != null)
                UserContactInfo(
                  title: 'Twitter',
                  content: user.twitter,
                ),
              if (user.instagram.isNotEmpty && user.instagram != null)
                UserContactInfo(
                  title: 'Instagram',
                  content: user.instagram,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserContactInfo extends StatelessWidget {
  final String title;
  final String content;

  UserContactInfo({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () => _launchUrl(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              title,
              style: TextStyle(
                  color: reclipIndigoDark, fontSize: ScreenUtil().setSp(12)),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: reclipIndigoDark, width: 1),
                ),
              ),
              child: AutoSizeText(
                content,
                style: TextStyle(
                    color: reclipBlack, fontSize: ScreenUtil().setSp(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchUrl(BuildContext context) async {
    final filteredLink = content.replaceAll('@', '');

    try {
      if (title.toLowerCase().contains('facebook')) {
        final facebookUrl = 'https://www.facebook.com/$filteredLink';
        if (await canLaunch(facebookUrl)) {
          await launch(facebookUrl, forceWebView: true);
        }
      } else if (title.toLowerCase().contains('twitter')) {
        final twitterUrl = 'https://www.twitter.com/$filteredLink';
        if (await canLaunch(twitterUrl)) {
          await launch(twitterUrl, forceWebView: true);
        } else {
          throw 'Could not launch URL';
        }
        print('go to twitter');
      } else if (title.toLowerCase().contains('instagram')) {
        final instagramUrl = 'https://www.instagram.com/$filteredLink';
        if (await canLaunch(instagramUrl)) {
          await launch(instagramUrl, forceWebView: true);
        } else {
          throw 'Could not launch URL';
        }
        print('go to instagram');
      } else if (title.toLowerCase().contains('mobile number')) {
        final callUrl = 'tel:$filteredLink';
        if (await canLaunch(callUrl)) {
          await launch(callUrl);
        }
      }
    } catch (e) {
      Flushbar(
        backgroundColor: reclipBlack,
        messageText: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Woops Something Bad Happened, Try again later',
              style: TextStyle(color: Colors.red),
            ),
            Icon(
              FontAwesomeIcons.exclamationCircle,
              color: Colors.red,
            ),
          ],
        ),
      )..show(context);
    }
  }
}
