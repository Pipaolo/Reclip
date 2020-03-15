import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/illustration.dart';

class IllustrationHeader extends StatelessWidget {
  final Illustration illustration;

  const IllustrationHeader({Key key, this.illustration}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(900),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(845),
              decoration: BoxDecoration(
                color: reclipBlackDark,
              ),
              child: TransitionToImage(
                image: AdvancedNetworkImage(
                  illustration.imageUrl,
                  useDiskCache: true,
                  cacheRule: CacheRule(maxAge: Duration(days: 2)),
                ),
                fit: BoxFit.fitHeight,
                loadingWidget: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtil().setHeight(125),
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: reclipIndigo,
                boxShadow: [
                  BoxShadow(
                    color: reclipBlack,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              child: AutoSizeText(
                illustration.title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
