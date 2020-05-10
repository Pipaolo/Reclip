import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/video.dart';

class PopularVideoInfo extends StatelessWidget {
  final Video popularVideo;
  final ReclipContentCreator popularContentCreator;

  const PopularVideoInfo(
      {Key key, this.popularVideo, this.popularContentCreator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final convertedDate =
        popularVideo.publishedAt.toString().split('T').removeAt(0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.solidHeart,
                    color: reclipIndigoLight,
                    size: ScreenUtil().setSp(25),
                  ),
                  Text(
                    popularVideo.likeCount.toString(),
                    style: TextStyle(
                      color: reclipBlack,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('yyyy').format(
                    DateTime.parse(
                      convertedDate,
                    ),
                  ),
                  style: TextStyle(
                    color: reclipIndigo,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function function;

  const CustomIconButton({Key key, this.icon, this.title, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: function,
          child: Column(
            children: <Widget>[
              icon,
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
