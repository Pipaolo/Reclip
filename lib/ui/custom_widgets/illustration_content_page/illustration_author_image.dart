import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/router/route_generator.gr.dart';

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
      radius: ScreenUtil().setSp(40),
      child: Stack(
        children: <Widget>[
          TransitionToImage(
            image: AdvancedNetworkImage(user.imageUrl, useDiskCache: true),
            borderRadius: BorderRadius.circular(200),
            height: ScreenUtil().setHeight(90),
            width: ScreenUtil().setWidth(90),
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: Ink(
                child: InkWell(
                  borderRadius: BorderRadius.circular(200),
                  onTap: () => ExtendedNavigator.rootNavigator
                      .pushNamed(Routes.otherProfilePageRoute),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
