import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/route_generator.dart';
import '../../../data/model/reclip_content_creator.dart';

class IllustrationAuthorImage extends StatelessWidget {
  final ReclipContentCreator user;
  const IllustrationAuthorImage({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: ScreenUtil().setSp(100),
      child: Stack(
        children: <Widget>[
          TransitionToImage(
            image: AdvancedNetworkImage(user.imageUrl),
            borderRadius: BorderRadius.circular(200),
            height: ScreenUtil().setHeight(300),
            width: ScreenUtil().setWidth(300),
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: Ink(
                child: InkWell(
                  borderRadius: BorderRadius.circular(200),
                  onTap: () =>
                      Routes.sailor.navigate('other_user_profile_page'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
